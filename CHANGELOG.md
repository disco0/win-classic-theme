# Change Log

## 0.0.23

- __Editor__:

    - Fixed quick input colors

- __Semantic Tokens__:

    - __Lua__:

        - `namespace.depreciated` (Global Variable)

## 0.0.22

- __Editor__:

    - Fixed editor suggestion colors
    - Symbol and symbol reference highlight/emphasis

- __Semantic Tokens__:

    - __Global__:
        - `comment`
        - `class`
        - `keyword`
        - `variable.defaultLibrary.readonly`

    - __Powershell__:
        - `type`
        - `*.language`
        - `property`
        - `variable`
        - `variable.other.readwrite`
        - `function`
        - `operator`
        - `number`

    - __CSharp__:
        - `namespace`
        - `plainKeyword`
        - `controlKeyword`
        - `enum`
        - `enumMember`
        - `operator`
        - `parameter`
        - `property`
        - `member`
        - `member.static`
        - `field`
        - `local`
        - `local.declaration`
        - `preprocessorText`
        - `preprocessorKeyword`
        - `xmlDocCommentComment`
        - `xmlDocCommentName`
        - `xmlDocCommentAttributeName`
        - `xmlDocCommentDelimiter`
        - `xmlDocCommentText`

    - __Python__:
        - `intrinsic`
        - `selfParameter`
        - `function`
        - `function.declaration`
        - `module`

    - __Rust__:
        - `operator`
        - `variable.static.constant`
        - `lifetime`
        - `function.attribute`
        - `namespace`
        - `comment.documentation`
        - `formatSpecifier`
        - `*.intraDocLink`
        - `brace.injected`
        - `parenthesis.injected`
        - `semicolon.injected`
        - `comma.injected`
        - `angle.injected`
        - `punctuation.injected`
        - `generic.injected`
        - `operator.injected`

    - __Go__:
        - `namespace`
        - `operator`
        - `parameter`
        - `parameter.definition`
        - `*.definition`
        - `type.definition`
        - `function`
        - `function.definition`

    - __C__:
        - `property`
        - `variable`
        - `variable.local`
        - `variable.global`
        - `namespace`
        - `preprocessorText`
        - `preprocessorKeyword`
        - `enumMember`
        - `macro`
        - `memberOperatorOverload`

    - __Cpp__:
        - `namespace`
        - `preprocessorText`
        - `preprocessorKeyword`
        - `enumMember`
        - `macro`
        - `memberOperatorOverload`

    - __typescript__:
        - `namespace`
        - `enum`

- __TextMate Scopes__:

    - __GitConfig__:
        - Config Section Entry Name
        - Config Section
        - Config Section
        - Config Section Delimiters

    - __Python__:
        - Docstring Body
        - Docstring Delimiters (`"""`)

    - __YAML-tmLanguage__
        - Control Chars (, etc)
        - Top Level `name`
        - Top Level `name` - Delimiter `:`
        - Grammar Identifier
        - Top Level `repository`
        - Top Level `repository` - Delimiter `:`
        - Pattern Property Keyword - `pattern`
        - Pattern Property Delimiter
        - Include `#`
        - Include Identifier
        - Quoted Match String Quotation Marks
        - Quoted Include Quotation Marks
        - Unquoted Scope Name

    - __Powershell__:
        - Operator
        - Bracket Punctuation
        - Pipeline `|`, Continuation ```
        - Embedded Blocks

    - __BATS__:
        - Control Keywords
        - Support Function
        - Support Variable

    - __Autoconf__:
        - Logical Expression Scope
        - Logical Expression Punctutation

    - __Shellscript__:
        - Test Brackets (`[[` && `]]`), other Logical Expressions
        - Command Option Flags
        - Parameter Expansion Operator
        - Parameter Delimiters

    - __Go__:
        - Format String Expression
        - Punctuation - Period
        - Punctuation - Brackets
        - Function
        - (Quoted) Import Path

    - __C#__
        - Null Conditional Operator

    - __CSS__:
        - Variable Declaration
        - Variable Reference

    - __Lua__:
        - Table Property
        - Table Function Property
        - Function Identifier
        - EmmyLua Alias - Identifier


## 0.0.21

- __TS/JS__:
    - Tuple Element Labels - Fool me twice

## 0.0.20

- __TS/JS__:
    - Tuple Element Labels - Refined scope && color

## 0.0.19

- __TS/JS__:
    - Tuple Element Labels
    - `super` keyword

- __UI__:
    - Increased contrast on active activity bar item

## 0.0.18

- __CSS__:
    - Selectors
    - `!important`
    - Property Values

- __Markdown__:
    - Raw string
    - Quotation
    - Quotation begin punctuation

- __Shellscript__:
    - Subshell definition (fix for better-shellscript-syntax)
    - Quoted parameter expansion delimiters / operators (not final color)

- __YAML-tmLanguage__:
    - Control chars

- __{Java,Type}Script__:
    - Refined documentation comment blocks
    - Depreciated
    - Nullish coalescing operator

- __Svelte__:
    - Script tags

- __Rust__:
    - Note—Rust has a very poor/unrefined grammar in Code, it (and this theme) need improvement
    - Function Declaration (FIXME)
    - Attributes
    - Operators - `::` `&`
    - Attributes
    - Core Constants
    - Types
    - Core Types
    - Type parameter
    - Raw double quoted

## 0.0.17

- __Markdown:__ Styles for bold, italic, and combination

## 0.0.16

- __Shellscript:__ Refined regexp captures used in better-shell-syntax's grammar extension (used in extended sed parsing, etc)
- __Regexp:__ Tweaks to settings/scope for some styles, mostly related to sets
- __{Type,Java}Script:__ Regexp literal flags

## 0.0.15

- __TOML:__ Quick fix for 0.0.14

## 0.0.14

- __tmLanguages:__ Capture groups
- __TypeScript:__ Decorators (shadowed by semantic highlighting)
- __Ruby:__ Function names
- __INI:__ Section group titles, keywords
- __TOML:__ Table keys

## 0.0.13

- __Log:__ Scopes for grammar used by extension `emilast.logfilehighlighter`
- __Editor:__ background, border, placeholderForeground, foreground
- __Editor:__ inputOption: activeForeground, activeBackground

## 0.0.12

- __JSON-tmLanguage:__ Adjustment for questionable top level error scope

## 0.0.11

- __RegExp:__ General scoping for nested contexts
- __Stylus:__ _ibid._

## 0.0.10

- __Stylus:__ Added selectors for basic syntax elements

## 0.0.9

- __JSON:__ Property keys now switch between a set of colors for aiding navigation.
- __JSON:__ Property key escaped char tweak.

## 0.0.8

- Lightened background of folded code and indent guides, active and inactive

## 0.0.7

- Import Statements: Added color and styles for (non-language scoped) `import`
  and `from` keywords-added to fix python specifically, but should improve any
  other language with a non-language scoped usage of the keywords.

## 0.0.6

- __Javascript:__ Import statements and object literals
- __Lua:__ EmmyLua Documentation Type (For [EmmyLua](https://marketplace.visualstudio.com/items?itemName=tangzx.emmylua)'s EmmyLua syntax)

## 0.0.5

- Shebangs
- Odds and ends for syntaxes in TextMate Languages extension

## 0.0.4

- Defined color for YAML keys
- Terminal colors

## 0.0.3

- Worked on everything except the actual theme

## 0.0.2

- General filling in of unset theme values
- Buttons/notifications changed to red
- Other less notable tweaks to improve consistency

## 0.0.1

- Initial release
