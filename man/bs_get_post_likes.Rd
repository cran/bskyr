% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feed_post_likes.R
\name{bs_get_post_likes}
\alias{bs_get_post_likes}
\title{Retrieve likes on a post}
\usage{
bs_get_post_likes(
  uri,
  limit = NULL,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
}
\arguments{
\item{uri}{Character, length 1. URI for post to get.}

\item{limit}{Integer. Maximum number to request. Maximum: \code{100}}

\item{user}{Character. User name to log in with. Defaults to \code{get_bluesky_user()}.}

\item{pass}{Character. App password to log in with. Defaults to \code{get_bluesky_pass()}.}

\item{auth}{Authentication information. Defaults to \code{bs_auth(user, pass)}.}

\item{clean}{Logical. Should output be cleaned into a \code{tibble}? Default: \code{TRUE}.}
}
\value{
a \link[tibble:tibble]{tibble::tibble} of likes
}
\description{
Retrieve likes on a post
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getLikes.json}{feed/getLikes.json (2023-10-01)}
}

\section{Function introduced}{

\code{v0.0.1} (2023-10-01)
}

\examples{
\dontshow{if (has_bluesky_pass() && has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_get_post_likes('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
\dontshow{\}) # examplesIf}
}
\concept{feed}
