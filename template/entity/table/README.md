# Table

## Definition

A table is used to represent tabular data.

## Usages

* Present tabular data
* Structure a form for updating and editing tabular data

## Features

### Customizing the Table

The "striped" CSS class can be added to the root `table` element to add zebra striping to the table.

The "bordered" CSS class can be added to the root `table` element to add rounded borders around the table. Each
individual row within the table will already have borders between each row, even without the "bordered" class.

The "condensed" CSS class can be added to the root `table` element to reduce the margin and padding from cells.

### Highlighting Rows

Upon hover, each row within the table will be softly highlighted so that the User can easily spot the cells within the
row they are currently viewing. The color used for this hover highlight should be a unique color, different from the
colors used in zebra striping, static row higlighting (below), and header rows/cells.

Also, static highlighting can be added to a row so that a specific row will always be highlighted by adding the
"highlight" CSS class to the targeted `tr` element. This should also be a unique color (also different than the color
used in hover highlighting).

### Scrollable Table

By adding the "scrollable" CSS class to a table, the `tbody` element of a table will be given a fixed maximum height
of 350 pixels and scrollbars will be added if the total height of the rows within the `tbody` extend beyond this fixed
height. When scrolling, however, both `thead` and `tfoot` will remain in a static position, creating a compact table
that can provide a large amount of tabular data without consuming an excessive amount of space on the page.

## Responsive Considerations

TODO