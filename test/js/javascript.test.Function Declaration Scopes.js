/** Function Declaration Scope Tests
 * - Some scopes to add, found after looking into solutions for a stackoverflow
 *   question <https://stackoverflow.com/a/47219148>
 * @language Javascript (Babel) <ext install mgmcdermott.vscode-language-babel>
 */

const functionConstArrow = () => "";
/*  meta.definition.variable variable.other.constant entity.name.function

    {
        "name":  "Function Declaration: const",
        "scope": "meta.var.expr meta.definition.variable variable.other.constant entity.name.function",
        "settings": {
            "foreground": "#0AF",
            "style":      "underline"
        }
    }

    entity.name.function.js
    variable.other.constant.js
    meta.definition.variable.js
    meta.var-single-variable.expr.js
    meta.var.expr.js
    source.js
*/
var functionVarArrow = () => "";
/*  meta.var.expr meta.definition.variable entity.name.function

    {
        "name":  "Function Declaration: var",
        "scope": "meta.var.expr meta.definition.variable entity.name.function",
        "settings": {
            "foreground": "#F0A",
            "style":      "italic bold"
        }
    }

    entity.name.function.js
    meta.definition.variable.js
    meta.var-single-variable.expr.js
    meta.var.expr.js
    source.js
*/

function functionFunc(){ return "" }
/*  entity.name.function

    {
        "name":  "Function Declaration: Function Keyword",
        "scope": "entity.name.function",
        "settings": {
            "foreground": "#000",
            "style":      ""
        }
    }

    entity.name.function.js
    meta.definition.function.js
    meta.function.js
    source.js
*/

functionVarArrow()
functionConstArrow()
functionFunc()
/*  meta.function-call entity.name.function

    {
        "name": "Function Call",
        "scope": "meta.function-call entity.name.function",
        "settings": {
            "foreground": "#F00",
            "style":      "italic"
        }
    }
*/


/** All textmate rules together:
    "editor.tokenColorCustomizations":{
        "textmateRules": [
            {
                "name":  "Function Declaration: const",
                "scope": "meta.var.expr meta.definition.variable variable.other.constant entity.name.function",
                "settings": {
                    "foreground": "#0AF",
                    "style":      "underline"
                }
            },
            {
                "name":  "Function Declaration: var",
                "scope": "meta.var.expr meta.definition.variable entity.name.function",
                "settings": {
                    "foreground": "#F0A",
                    "style":      "italic bold"
                }
            },
            {
                "name":  "Function Declaration: Function Keyword",
                "scope": "entity.name.function",
                "settings": {
                    "foreground": "#000",
                    "style":      ""
                }
            },
            {
                "name": "Function Call",
                "scope": "meta.function-call entity.name.function",
                "settings": {
                    "foreground": "#F00",
                    "style":      "italic"
                }
            }
        ]
    }
 */