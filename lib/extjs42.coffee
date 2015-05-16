Extjs42View = require './extjs42-view'
{CompositeDisposable} = require 'atom'

module.exports = Extjs42 =
  extjs42View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @extjs42View = new Extjs42View(state.extjs42ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @extjs42View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'extjs42:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @extjs42View.destroy()

  serialize: ->
    extjs42ViewState: @extjs42View.serialize()

  toggle: ->
    console.log 'Extjs42 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
