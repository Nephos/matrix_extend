# matrix_extend

Matrix implementation in crystal-lang.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  matrix_extend:
    github: Nephos/matrix_extend
```


## Usage

Don't hesitate to read the specs.
Every methods are described there.

```crystal
require "matrix_extend"
include MatrixExtend

m1 = Matrix(Int32).new(3, 2, 1)
m2 = Matrix(Int32).new(2, 3, 0)
# => matrix with 3 lines, 2 columns, filled with 1
m2 * m1
```


## Development

No particular development directives.

## Contributing

1. Fork it ( https://github.com/Nephos/matrix_extend/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Nephos](https://github.com/Nephos) Arthur Poulet - creator, maintainer
