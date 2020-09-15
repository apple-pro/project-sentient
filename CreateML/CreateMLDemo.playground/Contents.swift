import Cocoa
import CreateML

let filePath = "/Users/startupbuilder/Developer/Sentient/CreateML"
let trainingDataFile = String(format: "%@/%@", filePath, "twitter-sanders-apple.csv")
let modelOutputPath = String(format: "%@/%@", filePath, "TweetSentimentClassifier.mlmodel")

let data = try! MLDataTable(contentsOf: URL(fileURLWithPath: trainingDataFile))

let (trainingData, testData) = data.randomSplit(by: 0.8, seed: 100)

//thats it!!!, you now have a model!!!
let sentimentClassifier = try! MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

//save our model to a CoreML model
let metadata = MLModelMetadata(author: "lbibera", shortDescription: "My cool sentiment analyzer", version: "1.0")
try! sentimentClassifier.write(to: URL(fileURLWithPath: modelOutputPath))

//try using our model:

try sentimentClassifier.prediction(from: "@Apple is awesome")

try sentimentClassifier.prediction(from: "@Apple is crap")

try sentimentClassifier.prediction(from: "@Apple is a piece of shit")
