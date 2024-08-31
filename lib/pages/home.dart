import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_gallary_app/models/check_permission.dart';
import 'package:nft_gallary_app/models/directory_path.dart';
import 'package:nft_gallary_app/models/nft.dart';
import 'package:nft_gallary_app/services/imageto3dapi.dart';
import 'package:nft_gallary_app/services/nft_api.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solana/solana.dart';
import 'package:path/path.dart' as path;
// import 'package:babylonjs_viewer/babylonjs_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _publicKey;
  String? _balance;
  SolanaClient? client;
  final storage = const FlutterSecureStorage();
  bool _showNftExpanded = false;
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    var permission = await checkAllPermissions.isStoragePermission();
    var permissionLow = await checkAllPermissions.isStoragePermissionLow();
    if (permission || permissionLow) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    _readPk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // shrinkWrap: true,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text('Wallet Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(_publicKey ?? 'Loading...')),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            if (_publicKey != null) {
                              Clipboard.setData(
                                  ClipboardData(text: _publicKey!));
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(
            //   height: 400,
            //   child: Flutter3DViewer(
            //       src:
            //           'https://assets.meshy.ai/fe61d275-c975-4457-a36f-8e90ef8c6321/tasks/0191a446-fdd9-712a-aedd-61151c7732af/output/model.glb?Expires=1725297282&Signature=f3jsLO6yqvEJ46ji0r88NrmRdNPbZK2WGihZ0~Po8Eo2dim2kgXwUK7bmLygIY3qcKcY4tsuD1JoSvLj28sfQYfFJEiQLtuG07BLV-C~3faYcvnl5Ss-lDyqt6QcCRe1i8gkaagEgjqKkmznDcbgxDssy7-0O4OmaackM4QwADkHgpCKmpzYKOMflL60lgtJz9Y6qe8zTG7vhHVl00qd6Bqjz3~MAUF3uSve9Em3F5~MC8iwcjIcRmjvFVr0R9rJWB2pJyVFOznwH48eATJkyi1TZgXvrIuxXyDHI-BQeWZAESnYGUA5WvPPLtkRjOAYrCjtD1m1zZtuPpDvDK7yjA__&Key-Pair-Id=KL5I0C8H7HX83'),
            // ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text('Balance',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_balance ?? 'Loading...'),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            _getBalance();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Show Wallet NFTs'),
                    IconButton(
                      icon: Icon(_showNftExpanded
                          ? Icons.expand_less
                          : Icons.expand_more),
                      onPressed: () {
                        isPermission
                            ? setState(() {
                                _showNftExpanded = !_showNftExpanded;
                              })
                            : checkPermission();
                      },
                    )
                  ],
                ),
              ),
            ),
            if (_showNftExpanded)
              SingleChildScrollView(
                  child: SizedBox(
                      height: _showNftExpanded ? 310 : 0,
                      child: FutureBuilder<List<NFT>>(
                          future: fetchNFTs(_publicKey!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              final nfts = snapshot.data;
                              return ListView.builder(
                                  itemCount: (nfts?.length ?? 0) + 1,
                                  itemBuilder: (context, index) {
                                    if (nfts == null) {
                                      return IconButton(
                                        icon: const Icon(Icons.refresh),
                                        onPressed: () {
                                          fetchNFTs(_publicKey!);
                                        },
                                      );
                                    }
                                    if (index < nfts.length) {
                                      final nft = nfts[index];
                                      return TileList(
                                          name: nft.name ?? "",
                                          description: nft.description ?? "",
                                          image: nft.image ??
                                              "https://placehold.co/600x400/png");
                                      // ListTile(
                                      //   onTap: () async {
                                      //     await imageto3dResult(
                                      //         dotenv.env['MESHY_API_KEY'] ?? '',
                                      //         "0191a446-fdd9-712a-aedd-61151c7732af");
                                      //   },
                                      //   title: Text(nft.name ?? ""),
                                      //   subtitle: Text(nft.description ?? ""),
                                      //   leading: Image.network(
                                      //     nft.image ??
                                      //         "https://placehold.co/600x400/png",
                                      //   ),
                                      //   trailing: IconButton(
                                      //     onPressed: () {
                                      //       isPermission
                                      //           ? startDownload()
                                      //           : checkPermission();
                                      //     },
                                      //     icon: const Icon(Icons.download),
                                      //   ),
                                      // );
                                    } else {
                                      return IconButton(
                                        icon: const Icon(Icons.refresh),
                                        onPressed: () {
                                          setState(() {
                                            fetchNFTs(_publicKey!);
                                          });
                                        },
                                      );
                                    }
                                  });
                            }
                          }))),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Log out'),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        GoRouter.of(context).go("/");
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _readPk() async {
    final mnemonic = await storage.read(key: 'mnemonic');
    if (mnemonic != null) {
      final keypair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
      setState(() {
        _publicKey = keypair.address;
      });
      _initializeClient();
    }
  }

  void _initializeClient() async {
    final devnetEnabled = await getRPCtype();
    final rpcUrl = devnetEnabled
        ? dotenv.env['HELIUS_RPC_URL_DEVNET']
        : dotenv.env['HELIUS_RPC_URL'];
    final rpcwssUrl = devnetEnabled
        ? dotenv.env['HELIUS_RPC_WSS_DEVNET']
        : dotenv.env['HELIUS_RPC_WSS'];
    print("url : $rpcUrl and wss : $rpcwssUrl");
    client = SolanaClient(
      rpcUrl: Uri.parse(rpcUrl.toString()),
      websocketUrl: Uri.parse(rpcwssUrl.toString()),
    );
    _getBalance();
  }

  void _getBalance() async {
    setState(() {
      _balance = null;
    });
    final getBalance = await client?.rpcClient
        .getBalance(_publicKey!, commitment: Commitment.confirmed);
    final balance = (getBalance!.value) / lamportsPerSol;
    setState(() {
      _balance = balance.toString();
    });
  }
}

class TileList extends StatefulWidget {
  const TileList(
      {super.key,
      required this.name,
      required this.description,
      required this.image});
  final String name;
  final String description;
  final String image;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  var getPathFile = DirectoryPath();

  startDownload() async {
    final url = widget.image;
    // final url = await imageto3dResult(dotenv.env['MESHY_API_KEY'] ?? '',
    //     "0191a446-fdd9-712a-aedd-61151c7732af");
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      print("done $url");
      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (count, total) {
          setState(() {
            progress = (count / total);
          });
        },
      );
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    // GoRouter.of(context).go("/3dview");
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = path.basename(widget.image);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(widget.name),
          subtitle: Text(widget.description),
          leading: Image.network(
            widget.image,
          ),
          trailing: IconButton(
              onPressed: () {
                fileExists && dowloading == false
                    ? openfile()
                    : startDownload();
              },
              icon: fileExists
                  ? const Icon(
                      Icons.save,
                      color: Colors.green,
                    )
                  : dowloading
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 3,
                              backgroundColor: Colors.grey,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                            Text(
                              (progress * 100).toStringAsFixed(2),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        )
                      : const Icon(Icons.download))),
    );
  }
}
