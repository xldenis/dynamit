  attributes :created_time,:descriptor,:message,:link,:post_id,:author
  
  glue :source do
   attributes :provider
  end
