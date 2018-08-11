Dockerfile for Resembla
====

Dockerfile for [Resembla: Word-based Japanese similar sentence search library](https://github.com/tuem/resembla).

[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

## Features (quoted from the original repository)

- Candidate elimination using N-gram index and bit-parallel edit distance computation
- Word, kana and romaji-based edit distance variables and their ensemble
- Support vector regression with linguistic features

## Usage

### Build Index

```sh
$ docker run -it --rm -v $(pwd)/sample:/app/sample chimerast/resembla resembla_index -c sample/default.json
```

### Run CLI

```sh
$ docker run -it --rm -v $(pwd)/sample:/app/sample chimerast/resembla resembla_cli -c sample/default.json
> りんご食べたい
13      りんご食べた    0.864149
12      りんご食いたい  0.711577
13      りんご食った    0.670513
10      りんご食え      0.557662
1       りんごおいしい！！!!    0.524142
9       りんご買って    0.512157
8       りんごまずい    0.512111
```

### Run gRPC Server

```sh
$ docker run -it --rm -p 50051:50051 -v $(pwd)/sample:/app/sample chimerast/resembla resembla_server -c sample/default.json
```

Use [resembla.proto](https://github.com/tuem/resembla/blob/master/example/grpc/protos/resembla.proto).

## Licence

[Apache-2.0](LICENSE)

## Author

[Hideyuki TAKEUCHI (@chimerast)](https://github.com/chimerast)

## Reference

- https://engineering.linecorp.com/ja/blog/detail/226
