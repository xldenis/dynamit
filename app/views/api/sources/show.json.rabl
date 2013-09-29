object @source  
  attributes :identifier, :provider,:id,:user_id
  child @source.posts.limit(25) do
      extends "api/partials/post"
  end