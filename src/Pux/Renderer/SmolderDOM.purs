module Pux.Renderer.SmolderDOM where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, error, throwException)
import DOM (DOM)
import DOM.Event.EventTarget (EventListener, eventListener)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToParentNode)
import DOM.HTML.Window (document)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element)
import Data.List (List)
import Data.Maybe (Maybe(..))
import Pux.DOM.Events (DOMEvent)
import Pux.DOM.HTML (HTML)
import Signal (Signal, runSignal)
import Signal.Channel (CHANNEL, Channel, send)
import Text.Smolder.Markup (mapEvent)
import Text.Smolder.Renderer.DOM (patch)

select :: ∀ e. String → Eff (exception :: EXCEPTION, dom :: DOM | e) Element
select selector = do
  doc ← window >>= document >>= htmlDocumentToParentNode >>> pure
  elem ← querySelector (QuerySelector selector) doc
  case elem of
    Just elem' → pure elem'
    Nothing → throwException (error ("Pux.Renderer.SmolderDOM.select: No element matching " <> show selector))

adaptEventHandler :: ∀ ev eff. (Channel (List ev)) → (DOMEvent → ev) → EventListener (channel :: CHANNEL, dom :: DOM | eff)
adaptEventHandler input handler = eventListener \e → do
  send input $ pure $ handler e

renderToDOM :: ∀ ev fx. String → Signal (HTML ev) → Channel (List ev) → Eff (channel :: CHANNEL, exception :: EXCEPTION, dom :: DOM | fx) Unit
renderToDOM selector markup input = do
  target ← select selector
  runSignal $ markup <#> mapEvent (adaptEventHandler input) >>> patch target
