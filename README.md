zify
====

Zify (read "zee-ify") will add depth to images.  As input, it takes:

 * A Blender 3D template of how the letter "A" should be rendered.
 * A (more or less) black and white image.

It then traces the outlines of the black material in the image, and
substitutes that for the letter "A" in the template.  The result
is then rendered and output as an image.

Example input
-------------
![2d frog](https://user-images.githubusercontent.com/118367/51000550-7abc0500-14fb-11e9-8f5a-3c32966068c3.png)

Example output
--------------
![tall frog](https://user-images.githubusercontent.com/118367/51000542-74c62400-14fb-11e9-9d0d-2d42b5ac55c2.png)
![frog forest](https://user-images.githubusercontent.com/118367/51010030-6cccab00-1520-11e9-9c6c-067366c9f1b1.png)

Running zify
------------

If you have docker, you can run:

```
./zify_with_docker.sh design/example.blend input/frog.png out.png
```

If you are willing to install everything mentioned in the
`docker/Dockerfile` file, then you can run:

```
./zify.sh design/example.blend input/frog.png out.png
```
