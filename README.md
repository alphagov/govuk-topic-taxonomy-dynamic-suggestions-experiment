# GOV.UK Topic Taxonomy Dynamic Suggestions Experiment

A simple Rails app demonstrating how document similarity could be used to come up with [Topic Taxonomy](https://docs.publishing.service.gov.uk/manual/taxonomy.html) tag suggestions. This builds on the work we did in [the govuk-topic-taxonomy-static-suggestions-experiment repo](https://github.com/alphagov/govuk-topic-taxonomy-static-suggestions-experiment) by providing a dynamic user interface which allows users to see a list of suggested tags for a new or existing document on GOV.UK.

## Requirements

* Ruby (version specified in `.ruby-version`).
* PostgreSQL (version that supports the `pgvector` extension, e.g. v18).
* [The `pgvector` PostgreSQL extension](https://github.com/pgvector/pgvector).
* An [Open Router](https://openrouter.ai) account.

## Development

* Copy example environment file: `cp .env.example .env`.
* Set the value of `OPENROUTER_API_KEY` in `.env` to a suitable Open Router API key.
* Run `bin/setup` to setup and run the app in the development environment. Note that this will run `db:seed` which will take a few minutes to run.
* Visit the app in a browser at http://localhost:3000.

## Reference data

A bunch of reference data is included in the project and is loaded into the database via `bin/rails db:seed` which runs as part of `bin/setup`. Since the data exists in the repo, it's not necessary to generate it in order to run the app. However, the following describes the provenance of the reference data so it can be re-generated if required.

### Topic taxonomy

* [Setup a GOV.UK development environment](https://docs.publishing.service.gov.uk/manual/get-started.html).
* Setup the [Content Tagger application](https://docs.publishing.service.gov.uk/repos/content-tagger.html) so it can be run from [govuk-docker](https://docs.publishing.service.gov.uk/repos/govuk-docker.html).
* [Replicate](https://docs.publishing.service.gov.uk/repos/govuk-docker/how-tos.html#how-to-replicate-data-locally) the production data for Content Tagger locally.
* Run the following shell commands:


```
govuk-docker up -d content-store-lite
docker exec -i govuk-docker-content-store-lite-1 rails db < db/seeds/export-topic-taxonomy.sql > db/seeds/topic_taxonomy.csv
govuk-docker down content-store-lite
```

### Document embeddings

This data is obtained from [the govuk-topic-taxonomy-static-suggestions-experiment repo](https://github.com/alphagov/govuk-topic-taxonomy-static-suggestions-experiment):
* Copy all the JSON files from [the `transform/embeddings` directory](https://github.com/alphagov/govuk-topic-taxonomy-static-suggestions-experiment/tree/main/transform/embeddings) in the `govuk-topic-taxonomy-static-suggestions-experiment` repo to `db/seeds/embeddings`.
* Copy all the JSON files from [the `transform/clean` directory](https://github.com/alphagov/govuk-topic-taxonomy-static-suggestions-experiment/tree/main/transform/clean) in the `govuk-topic-taxonomy-static-suggestions-experiment` repo to `db/seeds/clean`.
