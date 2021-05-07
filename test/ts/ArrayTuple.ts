/**
 * All `Value1` and `Value2` tokens should be identically colored (also not black)
 */

// In Type

type TupleType =
[
    Value1: string,
    Value2: number
]

// In class

class         DepthState        { lookaheadDepth: [ Min: number, Max: number ] = [ 0, 1 ]; }
declare class AmbientDepthState { lookaheadDepth: [ Min: number, Max: number ] }

// In return type

declare function ambientReturnsArrayTuple(): [ Value1: any, Value2: never   ]
function returnsArrayTuple():                [ Value1: any, Value2: unknown ] 
{ return ["any", "unknown"] };

declare const ambientArrowReturnsArrayTuple: () => [ Value1: any, Value2: unknown ];
const arrowReturnsArrayTuple =               ():   [ Value1: any, Value2: unknown ] => ["any", "unknown"] 

// As cast

const castedAsTuple = '1 2'.split(' ') as [Value1: string, Value2: string];