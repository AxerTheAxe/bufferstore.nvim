# Bufferstore

Stores various buffer information in Neovim.

## Functionality

* Storage of the cursor position for each buffer.
    * This will stop Neovim from centering your view when switching between buffers.
* Storage and retention of the directories for no-name buffers.
    * This stops buffers with no associated file from losing their directory when switching between buffers.
* :ENoName command.
    * Creates a new no-name buffer at the directory specified as an argument to the command.

## Configuration

Here is the configuration with the default settings:

```lua
  cursor_position = {
    enabled = false -- Store cursor positions
  },
  no_name = {
    enabled = false, -- Store no-name directories and enable :ENoName
    pwd = true -- Print the new working directory after using :ENoName
  }
```

## Contributing

If you have any suggestions or find any bugs, please [submit an issue.](https://github.com/AxerTheAxe/bufferstore.nvim/issues/new)
If you would like to contribute code to this project, [pull requests are welcome.](https://github.com/AxerTheAxe/bufferstore.nvim/compare)

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE). Please review the license before contributing code.
