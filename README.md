# Sunstone Institute Homebrew Tap

```bash
brew tap sunstoneinstitute/tap
```

## Available formulae

| Formula | Description | Binary |
|---------|-------------|--------|
| horndb | Hybrid RDF reasoner (OWL 2 RL) with a SPARQL 1.1 HTTP frontend | `horndb` |
| worklode | Work tracker CLI for Sunstone Institute | `lode` |

### Install

```bash
brew install sunstoneinstitute/tap/horndb
brew install sunstoneinstitute/tap/worklode        # latest release
brew install --HEAD sunstoneinstitute/tap/worklode # build from main
```

`Formula/worklode.rb`'s `url` and `sha256` are rewritten by the worklode
release workflow on each `v*` tag.

## Available casks

| Cask | Description |
|------|-------------|
| op-who | Shows which process triggered a 1Password approval dialog |

### Install

```bash
brew install --cask sunstoneinstitute/tap/op-who
```
