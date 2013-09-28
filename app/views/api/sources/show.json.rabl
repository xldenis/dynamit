object @source  
  attributes :identifier, :provider,:id,:user_id
  child @source.posts.limit(25) do
    attributes :created_time,:descriptor,:message,:link,:post_id,:author
  end