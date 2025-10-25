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
# Fetch all lists created by a given user (actor)
user_lists <- bs_get_actor_lists('bskyr.bsky.social')
user_lists

## -----------------------------------------------------------------------------
first_list_uri <- user_lists$uri[1] # AT URI of the first list
first_list <- bs_get_list(first_list_uri) # retrieve detailed list info
first_list

## -----------------------------------------------------------------------------
bs_get_muted_lists()
bs_get_blocked_lists()

## -----------------------------------------------------------------------------
# Create a new curated list
new_list <- bs_new_list(
  name = '[vignette] Redistricting Experts',
  purpose = 'curatelist',
  description = 'A list of interesting people in redistricting'
)

## -----------------------------------------------------------------------------
# Add members to the list
bs_new_list_item(
  subject = 'chriskenny.bsky.social',
  uri = new_list$uri
)
bs_new_list_item(
  subject = 'simko.bsky.social',
  uri = new_list$uri
)
bs_new_list_item(
  subject = 'corymccartan.com',
  uri = new_list$uri
)

## -----------------------------------------------------------------------------
fourth_item <- bs_new_list_item(
  subject = 'bskyr.bsky.social', uri = new_list$uri
)
item_rkey <- bs_extract_record_key(fourth_item$uri)
bs_delete_list_item(item_rkey)

## -----------------------------------------------------------------------------
list_rkey <- bs_extract_record_key(new_list$uri)
bs_delete_list(list_rkey)

## -----------------------------------------------------------------------------
user_packs <- bs_get_actor_starter_packs('chriskenny.bsky.social')
user_packs |>
  dplyr::select(record_name, record_description)

## -----------------------------------------------------------------------------
bs_get_starter_pack('https://bsky.app/starter-pack/jkertzer.bsky.social/3laywns2q2v27') |>
  dplyr::select(record_name, record_description)

## -----------------------------------------------------------------------------
bs_get_starter_packs(c(
  'at://did:plc:bmc56x6ksb7o7sdkq2fgm7se/app.bsky.graph.starterpack/3laywns2q2v27',
  'https://bsky.app/starter-pack/chriskenny.bsky.social/3lb3g5veo2z2r'
)) |>
  dplyr::select(record_name, record_description)

## -----------------------------------------------------------------------------
pack <- bs_new_starter_pack(
  name = '[vignette] Redistricting people',
  list = new_list$uri, # use an existing list of accounts
  description = 'A starter pack of interesting redistricters'
)

## -----------------------------------------------------------------------------
# Delete the starter pack by its record key
pack_rkey <- bs_extract_record_key(pack$uri)
bs_delete_starter_pack(pack_rkey)

