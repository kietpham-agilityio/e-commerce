import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/entities/product_entities.dart';

class EcMockedData {
  static List<Map<String, Object?>> generateMockItems(int count) {
    return List.generate(
      count,
      (index) => {
        'id': index,
        'title': 'Debug tools Item $index',
        'body': 'This is a Debug tools item description for item $index',
      },
    );
  }

  static List<Map<String, Object?>> generateMockComments(int count) {
    return List.generate(
      count,
      (index) => {
        "postId": 1,
        "id": index + 1,
        "name": "Debug Tools name $index",
        "email": "Debugtool$index@example.com",
        "body": "This is a Debug tools comment description for item $index",
      },
    );
  }

  static EcHomeEntities generateHomeData() {
    return EcHomeEntities(
      discountProducts: [
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          discount: 15,
          finalPrice: 63.75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "15%",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          discount: 15,
          finalPrice: 63.75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "15%",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          discount: 15,
          finalPrice: 63.75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "15%",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          discount: 15,
          finalPrice: 63.75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "15%",
        ),
      ],
      newProducts: [
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "NEW",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "NEW",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "NEW",
        ),
        EcProduct(
          id: 152,
          name: "Running Sandals",
          description: "Comfort sandals for sport and outdoor wear.",
          brand: "Adidas",
          price: 75,
          quantity: 130,
          imageUrl: [
            "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
            "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
            "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
          ],
          label: "NEW",
        ),
      ],
    );
  }

  static List<EcCategoryEntity> generateShopData(int count) {
    return List.generate(
      count,
      (index) => EcCategoryEntity(id: index, name: 'Category $index'),
    );
  }
}
