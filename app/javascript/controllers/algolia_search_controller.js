import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hits", "hitsDesktop", "searchbox", "searchboxDesktop"]
  static values = {
    appId: String,
    searchKey: String
  }

  connect() {
    const { liteClient: algoliasearch } = window['algoliasearch/lite'];
    const searchClient = algoliasearch(this.appIdValue, this.searchKeyValue);

    this.search = instantsearch({
      indexName: 'products_index',
      searchClient,
      searchFunction: (helper) => {
        if (helper.state.query.trim() === '') {
          this.hitsTarget.style.display = 'none';
          this.hitsDesktopTarget.style.display = 'none';
          return;
        }
        this.hitsTarget.style.display = '';
        this.hitsDesktopTarget.style.display = '';
        helper.search();
      }
    });

    this.search.addWidgets([
      instantsearch.widgets.searchBox({ container: this.searchboxTarget }),
      instantsearch.widgets.searchBox({ container: this.searchboxDesktopTarget }),
      instantsearch.widgets.hits({
        container: this.hitsTarget,
        templates: {
          item(hit, { html, components }) {
            const url = `/products/${hit.objectId}`;
            return html`
              <a href="${url}" class="search-hit-item">
                <h2>${components.Highlight({ attribute: 'name', hit })}</h2>
              </a>
            `;
          },
        },
      }),
      instantsearch.widgets.hits({
        container: this.hitsDesktopTarget,
        templates: {
          item(hit, { html, components }) {
            const url = `/products/${hit.objectId}`;
            return html`
              <a href="${url}" class="search-hit-item">
                <h2>${components.Highlight({ attribute: 'name', hit })}</h2>
              </a>
            `;
          },
        },
      }),
    ]);

    this.search.start();
  }

  disconnect() {
    if (this.search) {
      this.search.dispose();
    }
  }
}