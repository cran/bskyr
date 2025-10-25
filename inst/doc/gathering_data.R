## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = '#>',
  eval = bskyr::has_bluesky_pass()
)

## -----------------------------------------------------------------------------
library(bskyr)

## ----eval= FALSE--------------------------------------------------------------
# auth <- bs_auth(user = bs_get_user(), pass = bs_get_pass())

## -----------------------------------------------------------------------------
bs_get_preferences()

## -----------------------------------------------------------------------------
profile <- bs_get_profile('chriskenny.bsky.social')
profile

## -----------------------------------------------------------------------------
bs_get_profile(actors = c('chriskenny.bsky.social', 'simko.bsky.social'))

## -----------------------------------------------------------------------------
feed <- bs_get_author_feed('chriskenny.bsky.social')
feed |>
  dplyr::select(uri, like_count, reply_count)

## -----------------------------------------------------------------------------
more_posts <- bs_get_author_feed('chriskenny.bsky.social', cursor = attr(feed, 'cursor')$cursor)

## -----------------------------------------------------------------------------
thread <- bs_get_post_thread('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
thread

## -----------------------------------------------------------------------------
post <- bs_get_posts('https://bsky.app/profile/chriskenny.bsky.social/post/3loagm2phgk2t')
post$record[[1]] |>
  dplyr::select(`$type`, text, created_at)

## -----------------------------------------------------------------------------
followers <- bs_get_followers('chriskenny.bsky.social')
followers

## -----------------------------------------------------------------------------
follows <- bs_get_follows('chriskenny.bsky.social')
follows

## -----------------------------------------------------------------------------
liked_posts <- bs_get_likes('bskyr.bsky.social')
liked_posts |>
  dplyr::select(author_handle, record_text)

## -----------------------------------------------------------------------------
bs_get_post_likes('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lnghukd7vk22')

## -----------------------------------------------------------------------------
bs_get_reposts('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lnghukd7vk22')

