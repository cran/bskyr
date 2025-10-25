## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = '#>',
  eval = bskyr::bs_has_pass()
)

## -----------------------------------------------------------------------------
library(bskyr)
auth <- bs_auth(user = bs_get_user(), pass = bs_get_pass())

## -----------------------------------------------------------------------------
bs_post(text = '[vignette] This is a post from R using `bskyr` on Creating Records.')

## -----------------------------------------------------------------------------
bs_post(
  text = '[vignette] This is a quote from R using `bskyr` on Creating Records',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpem3br3qn2z'
)

## -----------------------------------------------------------------------------
bs_post(
  text = '[vignette] This is a post with an image from R using `bskyr` on Creating Records',
  images = system.file('help/figures/logo.png', package = 'bskyr'),
  images_alt = 'A hexagon logo for bskyr with the letters "bskyr" on a cloud'
)

## -----------------------------------------------------------------------------
bs_post(
  text = '[vignette] This is a post with a link from R using `bskyr` on Creating Records. Check out the package at https://christophertkenny.com/bskyr/.',
)

## -----------------------------------------------------------------------------
bs_post(
  text  = '[vignette] This is a reply from R using `bskyr` on Creating Records',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m'
)

## -----------------------------------------------------------------------------
bs_like(post = 'https://bsky.app/profile/chriskenny.bsky.social/post/3lktjjvxvdk2g')

## -----------------------------------------------------------------------------
bs_repost(post = 'https://bsky.app/profile/chriskenny.bsky.social/post/3lktjjvxvdk2g')

## -----------------------------------------------------------------------------
post <- bs_post(text = '[vignette] This is a post to be deleted from R using `bskyr` on Creating Records.')
bs_delete_post(bs_extract_record_key(post$uri))

## -----------------------------------------------------------------------------
liked <- bs_like(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m')
reposted <- bs_repost(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m')

bs_delete_like(bs_extract_record_key(liked$uri))
bs_delete_repost(bs_extract_record_key(reposted$uri))

## -----------------------------------------------------------------------------
post_record <- list(
  text = '[vignette] Posting via bs_create_record()',
  createdAt = bs_created_at()
)
bs_create_record(collection = 'app.bsky.feed.post', record = post_record)

## -----------------------------------------------------------------------------
post_rcd <- bs_get_record(
  'https://bsky.app/profile/bskyr.bsky.social/post/3lpeonujcdg2q',
  clean = FALSE
)

like_record <- list(
  subject = list(
    uri = post_rcd$uri,
    cid = post_rcd$cid
  ),
  createdAt = bs_created_at()
)
bs_create_record(collection = 'app.bsky.feed.like', record = like_record)

