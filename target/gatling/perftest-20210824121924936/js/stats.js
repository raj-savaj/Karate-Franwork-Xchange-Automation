var stats = {
    type: "GROUP",
name: "Global Information",
path: "",
pathFormatted: "group_missing-name-b06d1",
stats: {
    "name": "Global Information",
    "numberOfRequests": {
        "total": "15000",
        "ok": "15000",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "557",
        "ok": "557",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "1701",
        "ok": "1701",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "693",
        "ok": "693",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "128",
        "ok": "128",
        "ko": "-"
    },
    "percentiles1": {
        "total": "650",
        "ok": "650",
        "ko": "-"
    },
    "percentiles2": {
        "total": "706",
        "ok": "706",
        "ko": "-"
    },
    "percentiles3": {
        "total": "972",
        "ok": "972",
        "ko": "-"
    },
    "percentiles4": {
        "total": "1193",
        "ok": "1193",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "count": 13029,
    "percentage": 87
},
    "group2": {
    "name": "800 ms < t < 1200 ms",
    "count": 1829,
    "percentage": 12
},
    "group3": {
    "name": "t > 1200 ms",
    "count": 142,
    "percentage": 1
},
    "group4": {
    "name": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "67.265",
        "ok": "67.265",
        "ko": "-"
    }
},
contents: {
"req_post--sample-po-bf66f": {
        type: "REQUEST",
        name: "POST /sample_post",
path: "POST /sample_post",
pathFormatted: "req_post--sample-po-bf66f",
stats: {
    "name": "POST /sample_post",
    "numberOfRequests": {
        "total": "15000",
        "ok": "15000",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "557",
        "ok": "557",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "1701",
        "ok": "1701",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "693",
        "ok": "693",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "128",
        "ok": "128",
        "ko": "-"
    },
    "percentiles1": {
        "total": "650",
        "ok": "650",
        "ko": "-"
    },
    "percentiles2": {
        "total": "707",
        "ok": "706",
        "ko": "-"
    },
    "percentiles3": {
        "total": "972",
        "ok": "972",
        "ko": "-"
    },
    "percentiles4": {
        "total": "1193",
        "ok": "1193",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "count": 13029,
    "percentage": 87
},
    "group2": {
    "name": "800 ms < t < 1200 ms",
    "count": 1829,
    "percentage": 12
},
    "group3": {
    "name": "t > 1200 ms",
    "count": 142,
    "percentage": 1
},
    "group4": {
    "name": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "67.265",
        "ok": "67.265",
        "ko": "-"
    }
}
    }
}

}

function fillStats(stat){
    $("#numberOfRequests").append(stat.numberOfRequests.total);
    $("#numberOfRequestsOK").append(stat.numberOfRequests.ok);
    $("#numberOfRequestsKO").append(stat.numberOfRequests.ko);

    $("#minResponseTime").append(stat.minResponseTime.total);
    $("#minResponseTimeOK").append(stat.minResponseTime.ok);
    $("#minResponseTimeKO").append(stat.minResponseTime.ko);

    $("#maxResponseTime").append(stat.maxResponseTime.total);
    $("#maxResponseTimeOK").append(stat.maxResponseTime.ok);
    $("#maxResponseTimeKO").append(stat.maxResponseTime.ko);

    $("#meanResponseTime").append(stat.meanResponseTime.total);
    $("#meanResponseTimeOK").append(stat.meanResponseTime.ok);
    $("#meanResponseTimeKO").append(stat.meanResponseTime.ko);

    $("#standardDeviation").append(stat.standardDeviation.total);
    $("#standardDeviationOK").append(stat.standardDeviation.ok);
    $("#standardDeviationKO").append(stat.standardDeviation.ko);

    $("#percentiles1").append(stat.percentiles1.total);
    $("#percentiles1OK").append(stat.percentiles1.ok);
    $("#percentiles1KO").append(stat.percentiles1.ko);

    $("#percentiles2").append(stat.percentiles2.total);
    $("#percentiles2OK").append(stat.percentiles2.ok);
    $("#percentiles2KO").append(stat.percentiles2.ko);

    $("#percentiles3").append(stat.percentiles3.total);
    $("#percentiles3OK").append(stat.percentiles3.ok);
    $("#percentiles3KO").append(stat.percentiles3.ko);

    $("#percentiles4").append(stat.percentiles4.total);
    $("#percentiles4OK").append(stat.percentiles4.ok);
    $("#percentiles4KO").append(stat.percentiles4.ko);

    $("#meanNumberOfRequestsPerSecond").append(stat.meanNumberOfRequestsPerSecond.total);
    $("#meanNumberOfRequestsPerSecondOK").append(stat.meanNumberOfRequestsPerSecond.ok);
    $("#meanNumberOfRequestsPerSecondKO").append(stat.meanNumberOfRequestsPerSecond.ko);
}
