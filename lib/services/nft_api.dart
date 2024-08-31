import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nft_gallary_app/models/nft.dart';

Future<List<NFT>> fetchNFTs(String address) async {
  final url = dotenv.env['HELIUS_RPC_URL'] ?? '';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jsonrpc": "2.0",
        "id": "my-id",
        "method": "searchAssets",
        "params": {
          "ownerAddress": "2FwBLURK4CpGqpsempCapgzd2fSrhZkT3FxnYyxsLWHm",
          "tokenType": "regularNft"
        }
      }));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final nftList = jsonData['result']['items'] as List<dynamic>;
    print(nftList.toString());
    final nfts = nftList.map((nftData) => NFT.fromJson(nftData)).toList();
    return nfts;
  } else {
    print("Coundn't fetch NFT");
    throw Exception('Failed to load NFTs: ${response.statusCode}');
  }
}



// Response from api

// {
//   "jsonrpc": "2.0",
//   "id": "my-id",
//   "method": "searchAssets",
//   "params": {
//     "ownerAddress": "2FwBLURK4CpGqpsempCapgzd2fSrhZkT3FxnYyxsLWHm",
//     "tokenType": "nonFungible"
//   }
// }


// {
//     "result": {
//         "items": [{
//             "interface": "V1_NFT",
//             "id": "FjBFdJKnqa8XzFYpv5q4rGDymHydTMCqASdpu29u6AJB",
//             "content": {
//                 "json_uri": "https://quicknode.myfilebase.com/ipfs/QmQHB7BaqXRgyZYVEEBrc7tHE4gAN6Be6YfrS4w1yUzwRS/",
//                 "metadata": {
//                     "description": "Green Q",
//                     "name": "QNCity",
//                 },
//             },
//         }]
//     },
// }