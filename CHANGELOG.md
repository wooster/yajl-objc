== 0.2.7

- Changed yajl_encodeJSON to JSON for YAJLCoding protocol
- Updating comments for YAJLCoding

== 0.2.6

- Supporting gen/parse from NSObject category (supports NSString, NSData and custom)
- Including standard/optimized build for arm6/7
- Include yajl_*.h api header files (iPhone)
- 32/64 bit universal build (Mac OSX)

== 0.2.5 

- Added YAJLGen wrapper for yajl_gen
- Added streaming support to YAJLDocument
- Added NSString category
- Added NSObject category

== 0.2.4

- Using yajl_number callback since its more compliant (correctly handles large double values)
- Changing YAJLParser API to allow for streaming data
- Added test for overflow.json
- Added test for insane sample.json

== 0.2.3

- Fixed memory leak in YAJLParser
