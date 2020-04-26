class LocalTime extends HTMLElement {
  timeStyle (name) {
    return ({
      medium: {},
      short: { hour: '2-digit', minute: '2-digit' }
    })[name]
  }

  constructor () {
    super()
    this._timeStyle = 'medium'
    this._date = null
  }

  _rerender () {
    this.innerHTML = new Date(this._date).toLocaleTimeString([], this.timeStyle(this._timeStyle))
  }

  static get observedAttributes () {
    return ['utc-time', 'time-style']
  }

  attributeChangedCallback (name, oldValue, newValue) {
    (({
      'utc-time': (newValue) => { this._date = newValue },
      'time-style': (newValue) => { this._timeStyle = newValue }
    })[name])(newValue)
    this._rerender()
  }
}

window.customElements.define('local-time', LocalTime)
