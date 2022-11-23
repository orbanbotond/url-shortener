### Algorythm
-------------
The shortened urls will be a conseqcutive series of base62 case sensitive alphanumerical strings.
The algorythm will create shortened urls for each url by incrementing the previous shortened url using the next character from the base 62 alphabet.

The base 62 alphabet will be:
0, 1, 2, ..., 9, a, b, c, ..., y, z, A, B, C, ..., Y, Z (10 + 26 + 26 = 62)

Source of algorythm:
https://en.wikipedia.org/wiki/URL_shortening

Genesis Record:
- The genesis record for the Url Shortener will be: '0'

Encoding Urls:
- If the Url exists in the DB then return the already encoded value for it.
- If the Url doesn't exist in the DB then it will read the last saved tiny URL and increment it. The newly incremented string will be the new shortened URL, then save the URL/shortenedURL pair into the DB.

Correctness of the Algorythm:
- Since the Encoded URLs are always an incrementing sequences of base62 chars they will always be unique, therefore there will always be a 1-1 mapping from URL to shortenedURL.

Scalability:
- The scalability will be simply ensured by the introduction of another base62 digit.
- Example: in the begining only one base62 digit will be used for encryption. That will be enough for encoding only 62 URLs. The 63rd URL will use 2 base62 alphanumerical case sensitive characters.
- The number of encodable URLs would be 62 on the power of number of base62 alphanumerical case sensitive characters. For 6 such 'chars' the maximum representable URLs will be: 56'800'235'584. (56+ billion). By the introduction of another 7th base62 alphanumerical case sensitive character we will expand the shortanable URLs.

Architecture:
-------------------
![alt text](./diagrams/architecture.png)



