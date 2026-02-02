import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hits", "hitsDesktop", "searchbox", "searchboxDesktop"]

  connect() {
    const { liteClient: algoliasearch } = window['algoliasearch/lite'];
    const searchClient = algoliasearch('<%= Rails.application.credentials.algolia[:application_id] %>',
                                      '<%= Rails.application.credentials.algolia[:search_api_key] %>');

    this.search = instantsearch({
      indexName: 'products_index',
      searchClient
    });

    this.search.start();
    console.log("Algolia search started")
  }

  disconnect() {
    console.log("Algolia search controller disconnected")
  }
}