class CommentBlueprint < Blueprinter::Base
  fields :worker_id, :message, :reply_to_comment_id
  field :updated_at, datetime_format:"%d/%m/%Y"
end