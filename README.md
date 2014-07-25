cykelapp
========

Google App Engine playground. I'm writing this readme primarily to help my
self at this point.

My development setup
--------------------

To get unit tests running, I added these:

```
sudo pip install Pillow
sudo pip install WebTest
sudo pip install unittest2
sudo pip install NoseGAE
```

To actually run the tests, I run this command in the root folder (assumes that
the GAE SDK is installed in `../google_appengine`:

```nosetests -v --with-gae --gae-lib-root=../google_appengine/ --without-sandbox```
