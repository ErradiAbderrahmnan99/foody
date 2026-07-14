<?php

namespace Database\Seeders;

use App\Enums\Ask;
use Illuminate\Database\Seeder;
use App\Models\Item;
use Illuminate\Support\Str;
use App\Enums\ItemType;
use App\Enums\Status;

class ItemTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public array $items = [
        [
            'name'        => 'Dumplings au Poulet',
            'image'       => 'chicken_dumplings',
            'category'    => 1,
            'tax_id'      => 2,
            'price'       => '2.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten et du soja.',
            'description' => 'Délicieux raviolis farcis au poulet et légumes, servis avec une sauce soja savoureuse.'
        ],
        [
            'name'        => 'Rouleaux Impériaux',
            'image'       => 'egg_roll',
            'category'    => 1,
            'tax_id'      => 2,
            'price'       => '1.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten.',
            'description' => 'Croustillants nems farcis de légumes de saison et de poulet émincé.'
        ],
        [
            'name'        => 'Wontons Frits au Fromage',
            'image'       => 'fried_cheese_wonton',
            'category'    => 1,
            'tax_id'      => 2,
            'price'       => '2.00',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient des produits laitiers et du gluten.',
            'description' => 'Bouchées croustillantes farcies de fromage à la crème onctueux et d\'épices douces.'
        ],
        [
            'name'        => 'Dumplings aux Légumes',
            'image'       => 'vegetable_dumplings',
            'category'    => 1,
            'tax_id'      => 2,
            'price'       => '2.50',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du soja.',
            'description' => 'Raviolis vapeurs sains et légers, garnis de légumes frais du marché.'
        ],
        [
            'name'        => 'Rouleau de Printemps Végétarien',
            'image'       => 'vegetable_roll',
            'category'    => 1,
            'tax_id'      => 2,
            'price'       => '1.00',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Sans gluten.',
            'description' => 'Galette de riz fraîche avec des légumes croquants et des herbes aromatiques.'
        ],
        [
            'name'        => 'Double Burger BBQ Américain',
            'image'       => 'american_bbq_double',
            'category'    => 2,
            'tax_id'      => 1,
            'price'       => '5.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten et du fromage.',
            'description' => 'Deux steaks hachés grillés à la flamme, cheddar fondant, laitue, tomate et notre sauce BBQ fumée.'
        ],
        [
            'name'        => 'Simple Burger BBQ Américain',
            'image'       => 'american_bbq_single',
            'category'    => 2,
            'tax_id'      => 1,
            'price'       => '4.00',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du fromage et du gluten.',
            'description' => 'Un steak haché grillé à la flamme, cheddar fondant, tomate fraîche et sauce BBQ maison.'
        ],
        [
            'name'        => 'Double Cheeseburger au Bacon',
            'image'       => 'bacon_double_cheeseburger',
            'category'    => 2,
            'tax_id'      => 2,
            'price'       => '3.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du porc et des produits laitiers.',
            'description' => 'Deux steaks juteux avec du bacon fumé croustillant et double portion de cheddar fondu.'
        ],
        [
            'name'        => 'Burger Bœuf Suprême',
            'image'       => 'whopper',
            'category'    => 2,
            'tax_id'      => 2,
            'price'       => '4.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten.',
            'description' => 'Steak haché pur bœuf de qualité supérieure, oignons caramélisés et sauce secrète.'
        ],
        [
            'name'        => 'Cheeseburger Classique',
            'image'       => 'cheeseburger',
            'category'    => 2,
            'tax_id'      => 2,
            'price'       => '3.00',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient de la moutarde et du lait.',
            'description' => 'L\'incontournable cheeseburger avec steak, cornichons, cheddar et sauce moutarde-ketchup.'
        ],
        [
            'name'        => 'Burger au Poulet Croustillant',
            'image'       => 'bbq_chicken',
            'category'    => 2,
            'tax_id'      => 2,
            'price'       => '3.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient des œufs et du gluten.',
            'description' => 'Filet de poulet pané doré et croustillant, mayonnaise douce et laitue fraîche.'
        ],
        [
            'name'        => 'Burger Végétal Original',
            'image'       => 'plant_based_whopper',
            'category'    => 3,
            'tax_id'      => 1,
            'price'       => '4.50',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du soja.',
            'description' => 'Galette végétale grillée à la flamme, cheddar vegan, oignons frais et sauce burger légère.'
        ],
        [
            'name'        => 'Burger Végan Gourmand',
            'image'       => 'vegan_royale',
            'category'    => 3,
            'tax_id'      => 1,
            'price'       => '5.00',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Convient aux végétaliens.',
            'description' => 'Un délicieux steak à base de plantes, avocat crémeux, roquette et tomate.'
        ],
        [
            'name'        => 'Sandwich au Poulet Grillé',
            'image'       => 'steak_sandwich',
            'category'    => 4,
            'tax_id'      => 1,
            'price'       => '4.00',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient des fruits à coque.',
            'description' => 'Filet de poulet mariné et grillé, servi dans un pain artisanal avec sauce pesto.'
        ],
        [
            'name'        => 'Club Sandwich Classique',
            'image'       => 'plain_grilled_chicken',
            'category'    => 4,
            'tax_id'      => 1,
            'price'       => '4.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten.',
            'description' => 'Triple épaisseur de pain de mie toasté avec dinde, bacon croustillant, tomate et laitue.'
        ],
        [
            'name'        => 'Salade César au Poulet',
            'image'       => 'classic_caesar_salad',
            'category'    => 8,
            'tax_id'      => 1,
            'price'       => '3.50',
            'type'        => ItemType::NON_VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du poisson et du fromage.',
            'description' => 'Salade romaine croquante, poulet grillé, croûtons dorés, parmesan et vinaigrette César maison.'
        ],
        [
            'name'        => 'Frites Maison',
            'image'       => 'french_fries',
            'category'    => 10,
            'tax_id'      => 1,
            'price'       => '1.50',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Frites à l\'huile végétale.',
            'description' => 'Frites de pommes de terre fraîches, coupées à la main et cuites à la perfection.'
        ],
        [
            'name'        => 'Rondelles d\'Oignon Croustillantes',
            'image'       => 'onion_rings',
            'category'    => 10,
            'tax_id'      => 1,
            'price'       => '2.00',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Contient du gluten.',
            'description' => 'Rondelles d\'oignons doux enrobées d\'une panure à la bière légère et croustillante.'
        ],
        [
            'name'        => 'Citronnade Maison',
            'image'       => 'homemade_lemonade',
            'category'    => 11,
            'tax_id'      => 1,
            'price'       => '1.50',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Sans conservateur.',
            'description' => 'Jus de citron frais pressé, eau purifiée, sucre de canne et feuilles de menthe fraîches.'
        ],
        [
            'name'        => 'Mojito Sans Alcool',
            'image'       => 'mojito',
            'category'    => 11,
            'tax_id'      => 1,
            'price'       => '2.00',
            'type'        => ItemType::VEG,
            'featured'    => Ask::YES,
            'caution'     => 'Très rafraîchissant !',
            'description' => 'Boisson rafraîchissante à base de menthe fraîche, citron vert, sucre et eau gazeuse.'
        ],
    ];

    public function run()
    {
        foreach ($this->items as $item) {
            $itemObject = Item::create([
                'name'             => $item['name'],
                'slug'             => Str::slug($item['name']),
                'item_category_id' => $item['category'],
                'price'            => $item['price'],
                'status'           => Status::ACTIVE,
                'tax_id'           => $item['tax_id'],
                'item_type'        => $item['type'],
                'order'            => 1,
                'is_featured'      => $item['featured'],
                'caution'          => $item['caution'],
                'description'      => $item['description']
            ]);

            $imagePath = public_path('/images/seeder/item/' . $item['image'] . '.png');
            if (file_exists($imagePath)) {
                $itemObject->addMedia($imagePath)
                    ->preservingOriginal()
                    ->toMediaCollection('item');
            }
        }
    }
}
