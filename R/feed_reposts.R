#' Retrieve actors who reposted a post
#'
#' @param uri `r template_var_uri()`
#' @param limit `r template_var_limit(100)`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept feed
#'
#' @return a [tibble::tibble] of actors
#' @export
#'
#' @section Lexicon references:
#' [feed/getRepostedBy.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getRepostedBy.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_reposts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3kaa2gxjhzr2a')
bs_get_reposts <- function(uri, limit = NULL,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must list at least one user.')
  }
  if (!is.character(uri)) {
    cli::cli_abort('{.arg uri} must be a character vector.')
  }

  if (!is.null(limit)) {
    if (!is.numeric(limit)) {
      cli::cli_abort('{.arg limit} must be numeric.')
    }
    limit <- as.integer(limit)
    limit <- max(limit, 1L)
    limit <- min(limit, 100L)
  }

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.feed.getRepostedBy') |>
    httr2::req_url_query(uri = uri) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_url_query(
      limit = limit
    )
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    purrr::pluck('repostedBy') |>
    proc() |>
    add_singletons(resp) |>
    clean_names()
}
