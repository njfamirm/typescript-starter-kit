import {AlwatrElement} from '@alwatr/element';
import {html, css, CSSResultGroup} from 'lit';
import {customElement} from 'lit/decorators/custom-element.js';

import type {TemplateResult} from 'lit';

@customElement('alwatr-element')
export class Phrase extends AlwatrElement {
  static override styles?: CSSResultGroup = [
    css`
    * {
      padding: 0;
      margin: 0;
      box-sizing: border-box;
    }
    `,
  ];

  override render(): TemplateResult {
    return html`
    <p dir=ltr>Hello world!</p>
    <p>سلام دنیا!</p>
    `;
  }
}
