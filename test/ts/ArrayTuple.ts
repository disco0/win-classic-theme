type TupleType =
[
    Value1: string,
    Value2: number
]

// In class

class DepthState
{
    groupDepthMax:    number = 1;
    groupDepthMin:    number = 0;
    lookaheadDepth: [ Min: number, Max: number ] = [ 0, 1 ];
}