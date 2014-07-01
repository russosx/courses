$(function () {
    $('#container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Пример пагинации Highcharts',
        },
        xAxis: {
            categories: ['Иванов К.С.', 'Петров А.К.', 'Сидоров О.Н.', 'Лазарев Р.В.', 'Ершов В.В.', 'Никитин А.С.', 'Смирнов Н.С.', 'Кузнецов К.С.', 'Соколов И.С.', 'Попов К.Р.']
        },
        
        yAxis: {
            startOnTick: false
        },
        plotOptions: {
            bar: {
                events: {
                    legendItemClick: function (event) { 
                        var seriesIndex = this.index;
                        var series = this.chart.series;
                        for (var i = 0; i < series.length; i++)
                        {
                            series[i].hide();
                        }
                        var newCats = [];
                        for (var i = 0; i < series[this.index]['data'].length; i++) {
                            newCats[i] = series[this.index]['data'][i]['name'];
                        };
                        this.chart.xAxis[0].setCategories(newCats);
                    }        
               },
           },
        },
        tooltip: {
            
        },
        legend: {
            symbolHeight: 0,
            symbolPadding: 0,
            symbolWidth: 0,
        },
        series: 
        [
            {
            name: '1',
            visible: true,
            color: "#87b7db",  
                data: [
                    {
                        name: "Иванов К.С.",
                        y: 679
                    },
                    {
                        name: "Петров А.К.",
                        y: 653
                    },
                    {
                        name: "Сидоров О.Н.",
                        y: 610
                    },
                    {
                        name: "Лазарев Р.В.",
                        y: 597
                    },
                    {
                        name: "Ершов В.В.",
                        y: 569
                    },
                    {
                        name: "Никитин А.С.",
                        y: 547
                    },
                    {
                        name: "Смирнов Н.С.",
                        y: 530
                    },
                    {
                        name: "Кузнецов К.С.",
                        y: 524
                    },
                    {
                        name: "Соколов И.С.",
                        y: 512
                    },
                    {
                        name: "Попов К.Р.",
                        y: 501
                    },
                ]        
            },
            {
            name: '2',
            visible: false,
            color: "#87b7db",  
                data: [
                    {
                        name: "Лебедев К.С.",
                        y: 499
                    },
                    {
                        name: "Козлов А.К.",
                        y: 476
                    },
                    {
                        name: "Новиков О.Н.",
                        y: 470
                    },
                    {
                        name: "Морозов Р.В.",
                        y: 451
                    },
                    {
                        name: "Петров В.В.",
                        y: 444
                    },
                    {
                        name: "Волков А.С.",
                        y: 432
                    },
                    {
                        name: "Соловьёв Н.С.",
                        y: 424
                    },
                    {
                        name: "Васильев К.С.",
                        y: 412
                    },
                    {
                        name: "Зайцев И.С.",
                        y: 403
                    },
                    {
                        name: "Павлов К.Р.",
                        y: 399
                    },
                ]        
            },
            {
            name: '3',
            visible: false,
            color: "#87b7db",  
                data: [
                    {
                        name: "Семёнов К.С.",
                        y: 387
                    },
                    {
                        name: "Голубев А.К.",
                        y: 381
                    },
                    {
                        name: "Виноградов О.Н.",
                        y: 367
                    },
                    {
                        name: "Богданов Р.В.",
                        y: 360
                    },
                    {
                        name: "Воробьёв В.В.",
                        y: 351
                    },
                    {
                        name: "Фёдоров А.С.",
                        y: 343
                    },
                    {
                        name: "Михайлов Н.С.",
                        y: 336
                    },
                    {
                        name: "Беляев К.С.",
                        y: 312
                    },
                    {
                        name: "Тарасов И.С.",
                        y: 295
                    },
                    {
                        name: "Белов К.Р.",
                        y: 274
                    },
                ]        
            }
        ]
    });
});