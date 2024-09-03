class NFT {
  String? image;
  String? name;
  String? description;

  NFT({
    this.image,
    this.name,
    this.description,
  });

  // Constructor to create an NFT object from a Map
  NFT.fromJson(Map<String, dynamic> json) {
    image = json['content']['links']['image'] == 'null'
        ? json['content']['links']['animation_url']
        : json['content']['links']['image'] as String;
    name = json['content']['metadata']['name'] as String;
    description = json['content']['metadata']['description'] as String;
  }

  // Method to convert NFT object back to a Map (useful for serialization)
  Map<String, dynamic> toJson() => {
        'links': {
          "image": image,
        },
        'metadata': {
          'name': name,
          'description': description,
        },
      };
}
