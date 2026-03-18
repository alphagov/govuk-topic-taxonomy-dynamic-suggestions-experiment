\copy (
with taxon_content_items as (
  select
    id,
    title,
    base_path,
    expanded_links
  from content_items
  where document_type = 'taxon'
  and phase <> 'alpha'
),
top_level_taxons as (
  select
    id,
    title,
    base_path
  from taxon_content_items
  where expanded_links->'root_taxon'->0->>'base_path' = '/'
),
taxons_and_parents as (
  select
    id,
    title,
    base_path,
    parent_taxons->>'base_path' as parent_base_path
  from taxon_content_items,
       jsonb_array_elements(expanded_links->'parent_taxons') as parent_taxons
  where base_path not like '/world/%'
),
all_taxons as (
  select
    id,
    title,
    base_path,
    '' as parent_base_path
  from content_items
  where content_id = 'f3bbdec2-0e62-4520-a7fd-6ffd5d36e03a'

  union all

  select
    id,
    title,
    base_path,
    '/' as parent_base_path
  from top_level_taxons

  union all

  select
    id,
    title,
    base_path,
    parent_base_path
  from taxons_and_parents
)

select * from all_taxons
) to '/tmp/topic_taxonomy.csv' delimiter ',' csv header;

