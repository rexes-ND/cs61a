# My notes on `Composing Programs`
Python code consists of expressions and statements.
- Statement typically describe action.
- Expression typically describe computation.

Functions encapsulate logic that manipulates data.

Objects seamlessly bundles together data and the logic that manipulates that data.

A program that evaluates compound expressions is called interpreter.

One kind of primitive expression is a number. For example, 10 (`int`).

The most important kind of compound expression is a call expression.
The call expression has subexpressions: the `operator` is an expression
that precedes parantheses, which enclose a comma-delimited list of operand expressions. For example, `operator`(`operand`, `operand`) is call expression.
The operator specifies a function.

If a value has been given a name, we say that the name `binds` to the value.
In Python, we can establish new bindings using the assignment statement.
To retrieve the value by its name means that the interpreter has to maintain
some sort of memory that keeps track of the names, values, and bindings. The memory
is called an `environment`. In Python, names are often called `variable names` or
`variables` because they can be bound to different values in the course of executing
a program.

`Pure functions` are functions without any side effects. Moreover, pure functions must
always return the same value when called twice with the same arguments.

Function definition:
```
def <name>(<formal parameters>):
    return <return expression>
```
A `def` statement binds a name to a user-defined function created by the definition.

An environment in which an expression is evaluated consists of a sequence of `frames`.
Each frame contains `bindings`, each of which associates a name with its
corresponding value. There is a single global frame.

The name appearing in the function is called the `intrinsic name`.
The name in a frame is a `bound name`. There is a difference between the two:
different names may refer to the same function, but that function itself has only
one intrinsic name.

A description of the formal parameters of a function is called the function's
signature.

Applying a user-defined function introduces a second `local` frame, which is only
accessible to that function. To apply a user-defined function to some arguments:
1. Bind the arguments to the names of the function's formal parameters in a new
`local` frame.
2. Execute the body of the function in the environment that starts with this frame.

A name evaluates to the value bound to that name in the earliest frame of the current
environment in which that name is found.

To master the user of a functional abstraction, it is often useful to consider its
three core attributes. The `domain` of a function is the set of arguments it can take.
Then `range` of a function is the set of values it can return. The `intent` of a
function is the relationship it computes between inputs and output.

Rather than being evaluated, statements are executed. Expressions can also be
executed as statements, in which case they are evaluated, but their value is
discarded.

Compound statements typically span multiple lines and start with a one-line
header ending in a colon, which identifies the type of statement. Together,
a header and an indented suite of statements is called a `clause`. A compound
statement consists of one or more clauses:
```
<header>
    <statement>
    <statement>
    ...
<separating header>:
    <statement>
    <statement>
    ...
...
```
To execute a sequence of statements, execute the first statement. If that statement
does not redirect control, then proceed to execute the rest of the sequence of
statements, if any remain.

Recursive nature of sequence: `sequence = first statement + sequence`.

A conditional statement in Python consists of a series of headers and suites:
```
if <expression>:
    <suite>
elif <expression>:
    <suite>
else:
    <suite>
```
A while clause contains a header expression followed by a suite:
```
while <expression>:
    <suite>
```
A `traceback` message prints out the chain of function calls that lead up to the 
error, with the most recent function call at the bottom.
Notice that the lines in the traceback appear to be paired together.
The first line in such a pair has the following format:
`File "<file name>", line <number>, in <function>`
- `File name`: the name of the file that contains the problem.
- `Number`: the line number in the file that caused the problem,
or the line number that contains the next function call
- `Function`: the name of the function in which the line can be found.

The second line in the pair displays the actual line of code that makes the next
function call.

The very last line in the traceback message is the error statement.
An `error statement` has the following format: `<error type>: <error message>`.
- `Error type`: the type of error that was caused. These are usually descriptive
enough to help you narrow down your search for the cause of error.
- `Error message`: A more detailed description of exactly what caused the error.

Functions that manipulate functions are called higher-order functions.

Like local assignment, local `def` statements only affect the current local frame.
These local `def` statements don't even get evaluated.
Locally defined functions also have access to the name bindings in the scope in
which they are defined. This discipline of sharing names among nested definitions
is called `lexical scoping`.

To enable lexical scoping, 2 extensions to our environment model is required:
1. Each user-defined function has a parent environment: the environment in which
it was defined.
2. When a user-defined function is called, its local frame extends its parent
environment.

The parent of a function value is the first frame of the environment in which that
function was defined.
Functions without parent annotations were defined in the global environment.

Because locally defined functions "enclose" information in this way,
they are often called `closures`.

`Currying` is the transformation that allows converting multiple arguments into
a chain of functions that each take a single argument.

A lambda expression evaluates to a function that has a single return expression
as its body. Assignment and control statements are not allowed.

In general, programming languages impose restrictions on the ways in which
computational elements can be manipulated. Elements with the fewest restrictions
are said to have first-class status. Some of the "rights and priviliges" of
first-class elements are:
1. They may be bound to names.
2. They may be passed as arguments to functions.
3. They may be returned as the results of functions.
4. They may be included in data structures.

Python provides special syntax to apply higher-order functions as part of executing
a `def` statement, called a `decorator`.

```
>>> def trace(fn):
        def wrapped(x):
            print('-> ', fn, '(', x, ')')
            return fn(x)
        return wrapped
>>> @trace
    def triple(x):
        return 3 * x
>>> triple(12)
->  <function triple at 0x102a39848> ( 12 )
36
# Note that the name `triple` is not bound to this function.
# Instead, it is bound to the returned function value of calling `trace`
# on the newly defined `triple` function.
# Equivalent to `>>> triple = trace(triple)`
```
A function is called `recursive` if the body of the function calls the function
itself, either directly or indirectly.

A common pattern can be found in the body of many recursive functions.
The body begins with a `base case`, a condition statement that defines the behavior
of the function for the inputs that are simplest to process. Some recursive functions
can have multiple base cases. The base cases are then followed by one or more
recursive calls. Recursive calls simplify the original problem.

When a recursive procedure is divided among two functions that call each other,
the functions are said to be `mutually recursive`.

Mutually recursive functions can be turned into a single recursive function by
breaking the abstraction boundary between the two functions.

Every value in Python has a `class` that determines what type of value it is.

A sequence is an ordered collection of values.
- Length: A sequence has a finite length. An empty sequence has length 0.
- Element selection: A sequence has an element corresponding to any non-negative
integer index less than its length, starting at 0 for the first element.

Python includes several native data types that are sequences, the most important
of which is the `list`.

A `for` statement consists of a single clause with the form:
```
for <name> in <expression>:
    <suite>
```
The general form of list comprehension is:
```
[<map expression> for <name> in <sequence expression> if <filter expression>]
```
To evaluate a list comprehension, Python evaluates the `<sequence expression>`, which
must return an iterable value. Then, for each element in order, the element value is
bound to `<name>`, the filter expression is evaluated, and if it yields a true value,
the map expession is evaluated. The values of the map expression are collected into
a list.

Python includes two more behaviours:
- Membership: A value can be tested for membership in a sequence.
- Slicing: A slice of a sequence is any contiguous span of the original sequence.

The general technique of isolating the parts of our program that deals with how
data are represented from the parts that deal with how data are manipulated is a
powerful design methodology called `data abstraction`.

Objects combine data values behavior. Objects represent information, but also behave
like the things that they represent. Objects have attributes, which are named values
that are part of the object: `<expression>.<name>`. Objects also have methods, which are
function-valued attributes.

Mutable objects are used to represent values that change over time.

Because two lists may have the same contents but in fact be
different lists, we require a means to test whether two objects
are the same. Python includes two comparison operators, called `is`
and `is not`, that test whether two expressions in fact evaluate to
the identical object. Identity is a stronger condition than
equality. A list comprehension always creates a new list.

Lists and dictionaries have local state: they are changing values
that have some particular contents at any point in the execution
of a program.

```
def make_withdraw(balance):
    def withdraw(amount):
        nonlocal balance
        if amount > balance:
            return "Insufficient funds"
        balance = balance - amount
        return balance
    return withdraw
```

The `nonlocal` statement declares that whenever we change the
binding of the name `balance`, the binding is changed in the first
frame in which `balance` is already bound. Without `nonlocal`
statement, an assignment statement would always bind a name in the
first frame of the current environment. The `nonlocal` statement
indicates that the name appears somewhere in the environment other
than the first (`local`) frame or the last (`global`) frame.

Locally defined function can look up names outside of its local
frames. No `nonlocal` statement is required to access a non-local
name. By contrast, only after a `nonlocal` statement can a function
change the binding of names in the frames.

Non-local assignment is an important step on our path to viewing
a program as a collection of independent and autonomous objects,
which interact with each other but each manage their own internal state. In particular, non-local assignment has given us the ability
to maintain some state that is local to a function, but evolves
over successive calls to that function.

The approach, which encapsulates the logic for all operations on a
data value within one function that responds to different messages,
is a discipline called `message passing`. A program that uses
message passing defines dispatch functions, each of which may have
local state, and organizes computation by passing "messages" as the
first argument to those functions. The messages are strings that
correspond to particular behaviors.

Expressing programs as constraints is a type of `declarative
programming`, in which a programmer declares the structure of a
problem to be solved, but abstracts away the details of exactly
how the solution to the problem is computed.

An `iterator` is an object that provides sequential access to
values, one by one. The iterator abstraction has two components:
- a mechanism for retrieving the next element in the sequence
being processed
- a mechanism for signaling that the end of the sequence has been
reached and no further elements remain

The way that Python signals that there is no more values available
is to raise a `StopIteration` exception when `next` is called.

Any value that can produce iterators is called an `iterable` value.

A `generator` is an iterator returned by a special class of
function called a `generator function`. Generator functions are
distinguished from regular functions in that rather than containing
`return` statements in their body, they use `yield` statement to
return elements of a series. Generators control the execution of
the generator function, which runs until the next `yield` statement
is executed each time the generator's `__next__` method is invoked.

Every object has a type, called its `class`. To create new types
of date, new classes are implemented. An `attribute` of an object
is a name-value pair associated with the object, which is
accessible via dot notation. Functions that operate on the object
or perform object-specific computations are called methods.
User-defined classes are created by `class` statements, which consist
of a single clause.
```
class <name>:
    <suite>
```
When a class statement is executed, a new class is created and bound
to \<name> in the first frame of the current environment. The suite
is then executed. Class attributes are created by assignment
statements in the suite of a class statement, outside of any method
definition.
```
<expression> . <name>
```
To evaluate a dot expression:
1. Evaluate the \<expression> to the left of the dot, which yields
the object of the dot expression.
2. \<name> is matched against the instance attributes of that
object; if an attribute with that name exists, its value is
returned.
3. If \<name> does not appear among instance attributes, then
\<name> is looked up  in the clas, which yields a class attribute
value.
4. That value is returned unless it is a function, in which case a
bound method is returned instead.

If the object is an instance, then attribute assignment sets an
instance attribute. If the object is a class, then assignment sets
a class attribute.

A subclass inherits the attributes of its base class, but may
override certain attributes, including certain methods. With
inheritance, we only specify what is different between the
subclass and the base class. To look up a name in a class:
1. If it names an attribute in the class, return the attribute
value.
2. Otherwise, look up the name in the base class, if there is one.

Python supports the concept of a subclass inheriting attributes
from multiple base classes, a language feature called
`multiple inheritance`. In `inheritance graph`, each arrow
points from a subclass to a base class. Python resolves names from
left to right, then upwards.

Python resolves this name using a recursive algorithm called the
`C3 Method Resolution Ordering`. The method resolution order of
any class can be quiried using the `mro` method on all classes.

A central concept in object abstraction is a `generic function`,
which is function that can accept values of multiple different
types.

Python stipulates that all objects should produce two different
string representations: one that is human-interpretable text and
one that is a Python-interpretable expression.

An `interface` is a set of shared attribute names, along with a
specification of their behavior.

In evaluating an expression, the interpreter preserves all
`active` environments and all values and frames referenced
by those environments. An environment is active if it provides
the evaluation context for some expression being evaluated.
An environment becomes inactive whenever the function call for 
which its first frame was created finally returns.

Tree-recursive computational processes can often be made more
efficient through `memoization`, a powerful technique for
increasing the efficiency of recursive functions that repeat
computation. A memoized function will store the return value for
any arguments it has previously received.

```
def memo(f):
    cache = {}
    def memoized(n):
        if n not in cache:
            cache[n] = f(n)
        return cache[n]
    return memoize
```
A Python program is just a collection of text. Only through the
process of interpretation do we perform any meaningful computation
based on that text.

Many interpreters have an elegant common structure: two mutually
recursive functions. The first evaluates expressions in
environments; the second applies functions to arguments. These
recursive functions are recursive in that they are defined in terms
of each other: applying a function require evaluating the
expressions in its body, while evaluating an expression may involve
applying one or more functions.

Scheme programs consist of expressions, which are either call
expressions or special forms. A call expression consists of an
operator expression followed by zero or more operand
sub-expressions, as in Python. Both the operator and operand are
contained within parenthesis. For example, `(quotient 10 2)`.
Scheme exclusively uses prefix notation. Operators are often
symbols, such as `+` and `*`.

Scheme expressions may be primitives or combinations. Number
literals are primitives, while call expressions are combined forms
that include arbitrary sub-expressions. The evaluation procedure
of call expressions matches that of Python: first the operator and
operand expressions are evaluated, and then function that is the
value of the operator is applied to the arguments that are the
values of the operands.

The general form of an `if` expression is:
`(if <predicate> <consequent> <alternative>)`. To evaluate an `if`
expression, the interpreter starts by evaluating the `<predicate>`
part of the expression. If the `<predicate>` evaluates to a true
value, the interpreter then evaluates the `<consequent>` and
returns its value. Otherwise it evaluates the `<alternative>` and
returns its value.

Values can be named using the `define` special form:
`(define pi 3.14)`. New functions (called `procedures` in Scheme)
can be defined using a second version of the `define` special form.
For example, to define squaring, we write: 
`(define (square x) (* x x))`. The general form of a procedure
definition is: `(define (<name> <formal parameters>) <body>)`.

`lambda` is used to create procedures in the same way as `define`,
except that no name is specified for the procedure:
`(lambda (<formal-parameters>) <body>)`.

Pairs are built into the Scheme language. For historical reasons,
pairs are created with the `cons` built-in function, and the
elements of a pair are accessed with `car` and `cdr`:
```
(define x (cons 1 2))
x
(1 . 2)
(car x)
1
(cdr x)
2
```

Recursive lists are also built into the language, using pairs. A
special value denoted `nil` or `'()` represents.
```scheme
(cons 1
    (cons 2
        (cons 3
            (cons 4 nil)
        )
    )
)

(list 1 2 3 4)
```
Whether a list is empty can be determined using the primitive
`null?` predicate.

In Scheme, we refer to the symbols a and b rather than their values
by preceding them with a single quotation mark:
```scheme
(define a 1)
(define b 2)

(list a b)
(1 2)
(list 'a 'b)
(a b)
(list 'a b)
(a 2)
```
In Scheme, any expression that is not evaluated is said to be
`quoted`. Quotation also allows us to type in compound objects,
using the conventional printed representation for lists:
```scheme
(car '(a b c))
a
(cdr '(a b c))
(b c)
```
There is no single correct approach to handling errors in program.
`Exceptions` provides a general mechanism for adding error-handling
logic to programs. Raising an exception is a technique for
interrupting the normal flow of execution in a program, signaling
that some exceptional circumstance has arisen, and returning directly
to an enclosing part of the program that was designated to react to
that circumstance. An exception can be handled by an enclosing `try`
statement. A `try` statement consists of multiple clauses;
```python
try:
    <try suite>
except <exception class> as <name>:
    <except suite>
...
``` 
Parsing is a process of generating expression trees from raw text
input. A parser is a composition of two components: a lexical
analyzer and a syntactic analyzer. First, the `lexical analyzer`
partitions the input string into `tokens`, which are the minimal
syntactic unit of the language such as names and symbols. Second,
the `syntactic analyzer` constructs an expression tree from this
sequence of tokens. The sequence of tokens produced by the lexical
analyzer is consumed by the syntactic analyzer.

A procedure call that has not yet returned is active. Some
procedure calls are `tail calls`.

A tail call is a call expression in a tail context:
- The last body sub-expression in a `lambda` expression
- Sub-expressions 2 & 3 in a tail context `if` expression
- All non-predicate sub-expressions in a tail context `cond`
- The last sub-expression in a tail context `and` or `or`
- The last sub-expression in a tail context `begin`

In `declarative languages` such as SQL:
A "program" is a description of the desired result.
The interpreter figures out how to generate the result.

In `impertive language` such as Python:
A "program" is a descriptions of computational processes.
The interpreter carries out execution/evaluation rules.

```SQL
create table cities as
select 38 as latitude, 122 as longitude, "Berkeley" as name union
select 42, 71, "Cambridge" union
select 45, 93, "Minneapolis";
```

- A `select` statement creates a new table, either from
scratch or by projecting a table.
- A `create table` statement gives a global name to a
table.

A `select` statement always includes a comma-separated list of
column descriptions. A column description is an expression,
optionally followed by `as` and a column name:
`select [expression] as [name], [expressions] as [name], ...;`.
Selecting literals creates a one-row table. The union of two select
statements is a table containing the rows of both of their results.

A `select` statement can specify an input table using a `from` clause.
A subset of the rows of the input table can be selected using a
`where` clause. An ordering over the remaining rows can be declared
using an `order by` clause.

Two tables A & B are joined by a comma to yield all combos of a row
from A & a row from B. Two tables may share a column name; dot
expressions and aliases disambiguate column values.