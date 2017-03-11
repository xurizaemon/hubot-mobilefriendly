# hubot-mobilefriendly

A hubot script to check a URL's mobile friendly rating via Google PageSpeed.

See [`src/mobilefriendly.coffee`](src/mobilefriendly.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-mobilefriendly --save`

Then add **hubot-mobilefriendly** to your `external-scripts.json`:

```json
["hubot-mobilefriendly"]
```

## Sample Interaction

```
user1>> hubot is github.com mobile friendly?
hubot>> Requesting Google PageSpeed report for http://example.org
hubot>> https://example.org/ is mobile friendly (100/100)
hubot>> https://www.google.com/webmasters/tools/mobile-friendly/?url=https://example.org/
```
