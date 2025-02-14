#' Get Profile for a Bluesky Social User
#'
#' @param actors character vector of actor(s), such as `'chriskenny.bsky.social'`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept actor
#'
#' @section Lexicon references:
#' [actor/getProfiles.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfiles.json)
#' [actor/getProfile.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfile.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @return a tibble with a row for each actor
#' @export
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_profile('chriskenny.bsky.social')
#' bs_get_profile(actors = c('chriskenny.bsky.social', 'simko.bsky.social'))
bs_get_profile <- function(actors,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(actors)) {
    cli::cli_abort('{.arg actors} must list at least one user.')
  }
  if (!is.character(actors)) {
    cli::cli_abort('{.arg actors} must be a character vector.')
  }
  # if (length(actors) == 1) {
  #   base_url <- 'https://bsky.social/xrpc/app.bsky.actor.getProfile'
  # } else {
  base_url <- 'https://bsky.social/xrpc/app.bsky.actor.getProfiles'
  # }
  if (length(actors) > 25) {
    cli::cli_abort(c(
      '{.arg actors} must be at most length 25.',
      'To support more actors, request this in an issue at {.url https://github.com/christopherkenny/bskyr/issues}.'
    ))
  }

  req <- httr2::request(base_url)

  # if (length(actors) == 1) {
  #   req <- req   |>
  #     httr2::req_url_query(actor = actors)
  # } else {
  actors <- actors |>
    as.list() |>
    purrr::set_names('actors')
  req <- rlang::inject(httr2::req_url_query(req, !!!actors))
  # }

  req <- req |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    purrr::pluck('profiles') |>
    proc() |>
    clean_names() |>
    add_req_url(req)
}
