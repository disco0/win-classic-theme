let symbol = 4

function functionIdent()
{
    console.log(symbol)
}

const symbolMut = () => symbol = 5

function callback(parameterIdent)
{
    return () => parameterIdent
}