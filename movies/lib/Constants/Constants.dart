import 'package:movies/models/interfaces/Movie.dart';
import 'package:movies/models/interfaces/MovieDetails.dart';
import 'package:movies/models/interfaces/Person.dart';
import 'package:movies/models/interfaces/PersonDetails.dart';
import 'package:movies/models/interfaces/SerieDetails.dart';
import 'package:movies/models/interfaces/TVSerie.dart';
import 'package:movies/models/typeAdapters/Movie.dart';

const String bearerV4Token =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NWUzNjdiYmQ4NDM0Y2ExYzJhNzNkNmM0ZmMyNDAyMiIsInN1YiI6IjYxZDlkMWRhNTVjOTI2MDAxYzJiOTMxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UQeGEMcj1gHdP9f-4Q0Mx0QMK1iJLWXqo5BlOdfLzwQ";

const String v3Token = "45e367bbd8434ca1c2a73d6c4fc24022";

const String basePathImages = "https://image.tmdb.org/t/p/original";

const String mediaType = "media_type";

const String youtubePath = "https://www.youtube.com/watch?v=";

// Movies internal names
const String movieID = "id";
const String movieTitle = "title";
const String movieOgTitle = "original_title";
const String movieOverview = "overview";
const String moviebdPath = "backdrop_path";
const String moviePosterPath = "poster_path";
const String movieReleaseDate = "release_date";
const String movieVoteAvg = "vote_average";
const String movieGenreIDs = "genre_ids";
const String movieVoteCount = "vote_count";
const String movieOgLanguage = "original_language";
const String moviePopularity = "popularity";

// Tv serie internal names
const String serieID = "id";
const String serieName = "name";
const String serieOgName = "original_name";
const String serieOverview = "overview";
const String seriebdPath = "backdrop_path";
const String seriePosterPath = "poster_path";
const String serieFirstAirDate = "first_air_date";
const String serieVoteAvg = "vote_average";
const String serieGenreIDs = "genre_ids";
const String serieVoteCount = "vote_count";
const String serieOgLanguage = "original_language";
const String seriePopularity = "popularity";

// Person internal names
const String personId = "id";
const String personName = "name";
const String personKnownFor = "known_for";
const String personDepartment = "known_for_department";
const String personPopularity = "popularity";
const String personProfilePath = "profile_path";

// Movie details internal names
const String movieDetailsHomepage = "homepage";
const String movieDetailsRuntime = "runtime";
const String movieDetailsBackdrops = "backdrops";
const String movieGenres = "genres";
const String movieDetailsFilePath = "file_path";
const String movieDetailsTrailer = "videos";
const String movieDetailsSimilars = "similar";
const String movieDetailsImages = "images";
const String movieDetailsWatchProviders = "watch/providers";

// Provider internal names
const String itLanguage = "IT";
const String streaming = "streaming";
const String providerName = "provider_name";
const String providerLogo = "logo_path";

// Person details internal names
const String personBirthday = "birthday";
const String personDeathday = "deathday";
const String personAlsoKnownAs = "also_known_as";
const String personBiography = "biography";
const String personPlaceOfBirth = "place_of_birth";
const String personProfiles = "profiles";

// Person details internal names
const String serieSeasons = "number_of_seasons";
const String serieEpisodes = "number_of_episodes";

// Initial state Movie
Movie initialMovie = Movie(0, "", "", "", "", 0, "", "", "", [], 0, 0, "");

// Initial state MovieHive
MovieHive initialMovieHive = MovieHive(0, "", "", "", "", 0, "", "", "", [], 0, 0, "");

// Initial state TVSerie
TVSerie initialSerie = TVSerie(0, "", "", "", "", 0, "", "", "", [], 0, 0, "");

// Initial state person
Person initialPerson = Person(0, "", "", [], 0, "");

MovieDetails initialMovieDetails = MovieDetails(
    0, "", "", [], [], [], 0, "", "", "", "", 0, "", "", "", [], 0, 0, "movie");

SerieDetails initialSerieDetails = SerieDetails(0, 0, "", "", [], [], [], 0, "",
    "", "", "", 0, "", "", "", [], 0, 0, "serie");

PersonDetails initialPersonDetails =
    PersonDetails("", [], "", "", "", "", 0, "", "", [], 0, "", "person");

// Genre ids in a map to be easier to access in
Map genreIds = {
  12: "Avventura",
  14: "Fantasy",
  16: "Animazione",
  18: "Dramma",
  27: "Horror",
  28: "Azione",
  35: "Commedia",
  36: "Storia",
  37: "Western",
  53: "Thriller",
  80: "Crime",
  99: "Documentario",
  878: "Fantascienza",
  9648: "Mistero",
  10402: "Musica",
  10749: "Romance",
  10751: "Famiglia",
  10752: "Guerra",
  10759: "Azione e Avventura",
  10762: "Bambini",
  10763: "News",
  10764: "Reality",
  10765: "Sci-Fi & Fantasy",
  10766: "Soap",
  10767: "Talk",
  10768: "Guerra e politica",
  10770: "Televisione film",
};
