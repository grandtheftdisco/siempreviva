module SoftDeletable
  extend ActiveSupport::Concern

  included do
    define_callbacks :soft_delete
    default_scope { where(deleted_at: nil) }
    scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
    scope :with_deleted, -> { unscope(where: :deleted_at) }
  end

  def soft_delete
    update_column :deleted_at, Time.now if has_attribute? :deleted_at
    update_column :status, "soft_deleted" if has_attribute? :status
  end

  def soft_delete_records
    dependent_associations.each do |association|
      associated_records = public_send(association.name)
      if association.options[:dependent] == :destroy
        associated_records.each(&:soft_delete)
      elsif association.options[:dependent] == :delete_all
        associated_records.update_all(deleted_at: Time.now)
      end
    end

    self.update(status: "soft_deleted", deleted_at: Time.now)
  end

  def restore
    dependent_associations.each do |association|
      deleted_records = public_send(association.name).only_deleted
      if association.options[:dependent] == :destroy
        deleted_records.each do |record|
          record.update(deleted_at: nil)
          record.update(status: nil) if record.has_attribute?(:status)
        end
      elsif association.options[:dependent] == :delete_all
        deleted_records.update_all(deleted_at: nil)
      end
    end

    self.update(deleted_at: nil, status: nil)
  end

  private

  def dependent_associations
    self.class.reflect_on_all_associations.select do |reflection|
      reflection.options[:dependent].present?
    end
  end
end
