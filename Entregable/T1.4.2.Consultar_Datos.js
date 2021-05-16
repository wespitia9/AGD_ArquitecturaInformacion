//identificar vendedores con reseñas malas
use('Resenas_Olist');

db.ordenes_Olist.aggregate([{
    $addFields: {
        Calificacion: "$review_score"
    }
}, {
    $match: {
        review_score: {
            $lte: 3
        }
    }
}, {
    $group: {
        _id: {
            seller_id: "$seller_id",
            Calificacion: "$Calificacion"
        },
        Conteo: {
            $sum: 1
        }
    }
}, {
    $project: {
        seller_id: "$_id.seller_id",
        Calificacion: "$_id.Calificacion",
        Conteo: "$Conteo"
    }
}, {
    $sort: {
        review_score: 1
    }
}])

//categorias de productos con reseñas malas
use('Resenas_Olist');
db.ordenes_Olist.aggregate([{
    $match: {
        review_score: {$lte: 3}
    }
}, {
    $group: {
        _id: {
            category_name: "$category_name"
        },
        conteo_productos: {
            $sum: 1
        },
        calificacion: {
            $avg: "$review_score"
        }
    }
}, {
    $project: {
        category_name: "$_id.category_name",
        conteo_productos: "$conteo_productos",
        calificacion: "$calificacion"
    }
}, {
    $sort: {
        calificacion: 1
    }
}])

//ciudadades con reseñas malas
use('Resenas_Olist');
db.ordenes_Olist.aggregate([{
    $match: {
        review_score: {$lte: 3}
    }
}, {
    $group: {
        _id: {
            customer_city: "$customer_city"
        },
        calificacion: {
            $avg: "$review_score"
        }
    }
}, {
    $project: {
        customer_city: "$_id.customer_city",
        calificacion: "$calificacion"
    }
}, {
    $sort: {
        calificacion: 1
    }
}])

//porcentaje de insatisfaccion
use('Resenas_Olist');
var total = db.ordenes_Olist.count();

db.ordenes_Olist.aggregate(
[
{$match: {review_score: {$lte: 3}}},
{$group: {_id: 0, conteo_malos: { $sum: 1 }}},
{$project: { "porcentaje_insatisfaccion": { 
                "$concat": [ { "$substr": [ { "$multiply": [ { "$divide": [ "$conteo_malos", total] }, 100 ] }, 0,2 ] }, "", "%" ]}
            }
        }
    ]
)

//%participacion por review score
var total = db.ordenes_Olist.count();

db.ordenes_Olist.aggregate(
[
{$group: {_id: {review_score: "$review_score"}, conteo: { $sum: 1 }}},
{$project: { review_score:"$_id.review_score",
             "ordenes": "$conteo",
             "porcentaje": { 
                "$concat": [ { "$substr": [ { "$multiply": [ { "$divide": [ "$conteo", total] }, 100 ] }, 0,2 ] }, "", "%" ]}
            }
        },
{$sort:{review_score: 1}}
    ]