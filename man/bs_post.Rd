% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/record_post.R
\name{bs_post}
\alias{bs_post}
\title{Make a post on Bluesky Social}
\usage{
bs_post(
  text,
  images,
  images_alt,
  video,
  video_alt,
  langs,
  reply,
  quote,
  emoji = TRUE,
  max_tries,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
}
\arguments{
\item{text}{text of post}

\item{images}{character vector of paths to images to attach to post}

\item{images_alt}{character vector of alt text for images. Must be same length as \code{images} if used.}

\item{video}{character vector of path for up to one video to attach to post}

\item{video_alt}{character vector, length one, of alt text for video, if used.}

\item{langs}{character vector of languages in BCP-47 format}

\item{reply}{character vector with link to the parent post to reply to}

\item{quote}{character vector with link to a post to quote}

\item{emoji}{boolean. Default is \code{TRUE}. Should \verb{:emoji:} style references be converted?}

\item{max_tries}{Integer, >= 2. Number of times to retry the request if the first fails.}

\item{user}{Character. User name to log in with. Defaults to \code{get_bluesky_user()}.}

\item{pass}{Character. App password to log in with. Defaults to \code{get_bluesky_pass()}.}

\item{auth}{Authentication information. Defaults to \code{bs_auth(user, pass)}.}

\item{clean}{Logical. Should output be cleaned into a \code{tibble}? Default: \code{TRUE}.}
}
\value{
a \link[tibble:tibble]{tibble::tibble} of post information
}
\description{
Make a post on Bluesky Social
}
\details{
\verb{:emoji:} parsing is not a formally supported Bluesky feature. This package
converts usages of this kind by identifying text within \code{:}s, here "\code{emoji}"
and then matches them to the \code{emoji} package's list of emoji names. All
supported emoji names and corresponding images can be seen with
\code{emoji::emoji_name}. This feature was introduced in \code{v0.2.0}.
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json}{feed/post.json (2024-11-29)}
\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json}{repo/createRecord.json (2023-10-02)}
}

\section{Function introduced}{

\code{v0.0.1} (2023-10-02)
}

\examples{
\dontshow{if (has_bluesky_pass() & has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_post('Test post from R CMD Check for r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')
bs_post('Test self-reply from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g'
)
bs_post('Test quoting from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
)
bs_post('Test quote and reply from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
)

bs_post('Test quote with :emoji: and :fire: and :confetti_ball: from r package
  `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')

bs_post(text = 'testing sending videos from R',
  video = fs::path_package('bskyr', 'man/figures/pkgs.mp4'),
  video_alt = 'a carousel of package logos, all hexagonal')
\dontshow{\}) # examplesIf}
}
\concept{record}
