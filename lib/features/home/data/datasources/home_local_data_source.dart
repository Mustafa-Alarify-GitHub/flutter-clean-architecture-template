import 'package:hive/hive.dart';

import '../../../../core/storage/storage_keys.dart';
import '../../domain/entities/product/product_entity.dart';
import '../models/product/product_model.dart';

abstract class HomeLocalDataSource {
  List<ProductEntity> fetchProducts();
  Future<void> saveProducts(List<ProductEntity> products);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl();

  @override
  List<ProductEntity> fetchProducts() {
    final productBox = Hive.box(StorageKeys.product_box);
    try {
      return productBox.values
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveProducts(List<ProductEntity> products) async {
    final productBox = Hive.box(StorageKeys.product_box);
    final Map<dynamic, Map<String, dynamic>> productMap = {
      for (var product in products)
        product.id: _productEntityToJson(product)
    };
    await productBox.putAll(productMap);
  }

  Map<String, dynamic> _productEntityToJson(ProductEntity product) {
    return {
      'id': product.id,
      'title': product.title,
      'description': product.description,
      'category': product.category,
      'price': product.price,
      'discountPercentage': product.discountPercentage,
      'rating': product.rating,
      'stock': product.stock,
      'tags': product.tags,
      'brand': product.brand,
      'sku': product.sku,
      'weight': product.weight,
      'dimensions': {
        'width': product.dimensions.width,
        'height': product.dimensions.height,
        'depth': product.dimensions.depth,
      },
      'warrantyInformation': product.warrantyInformation,
      'shippingInformation': product.shippingInformation,
      'availabilityStatus': product.availabilityStatus,
      'reviews': product.reviews.map((r) => {
        'rating': r.rating,
        'comment': r.comment,
        'date': r.date.toIso8601String(),
        'reviewerName': r.reviewerName,
        'reviewerEmail': r.reviewerEmail,
      }).toList(),
      'returnPolicy': product.returnPolicy,
      'minimumOrderQuantity': product.minimumOrderQuantity,
      'meta': {
        'createdAt': product.meta.createdAt.toIso8601String(),
        'updatedAt': product.meta.updatedAt.toIso8601String(),
        'barcode': product.meta.barcode,
        'qrCode': product.meta.qrCode,
      },
      'images': product.images,
      'thumbnail': product.thumbnail,
    };
  }
}
