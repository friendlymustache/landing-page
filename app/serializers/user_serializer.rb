class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  embed :ids, include: true, embed_in_root: true
end
