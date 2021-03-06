{% snapshot superheroes_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('tutorial', 'superheroes') }}

{% endsnapshot %}

{% snapshot users_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='user_id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('weekone', 'users') }}

{% endsnapshot %}