# purescript-pux-smolder-dom

A drop-in replacement for Pux's React based renderer which needs no foreign dependencies.

- [Module Documentation](https://pursuit.purescript.org/packages/purescript-pux-smolder-dom/)

## Usage

Simply replace `Pux.Renderer.React` with `Pux.Renderer.SmolderDOM` in your Pux application:

```purescript
import Pux.Renderer.SmolderDOM (renderToDOM)

...

renderToDOM "#app" app.markup app.input
```

## Licence

Copyright 2017 Bodil Stokke

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this program. If not, see
<http://www.gnu.org/licenses/>.
