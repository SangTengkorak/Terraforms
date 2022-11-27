# Create topic.
resource "google_pubsub_topic" "topic-from-tf" {
  name = "topic-from-tf"

  labels = {
    foo = "bar"
  }

  message_retention_duration = "600s"
}

# Create subscription.
resource "google_pubsub_subscription" "sub-from-tf" {
  name  = "sub-from-tf"
  topic = google_pubsub_topic.topic-from-tf.name

}