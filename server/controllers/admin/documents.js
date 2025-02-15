const mh = require("../../helpers/media_helper");
const util = require("util");
const Document = require("../../models/document");

exports.addDoc = async function (req, res) {
  try {
    // const uploadImage = util.promisify(
    //   mh.upload.fields([
    //     {
    //       name: "image",
    //       maxCount: 1,
    //     },
    //   ])
    // );
    // try {
    //   await uploadImage(req, res);
    // } catch (error) {
    //   console.error(error);
    //   return res.status(500).json({
    //     type: error.code,
    //     message: `${error.message}{${error.field}}`,
    //     storageErrors: error.storageErrors,
    //   });
    // }

    // const image = req.files["image"][0];
    // if (!image) return res.status(404).json({ message: "No file found" });
    // req.body["image"] = `${req.protocol}://${req.get("host")}/${image.path}`;

    let document = new Document(req.body);
    document = document.save();
    if (!document) {
      return res
        .status(500)
        .json({ message: "The document could not be created" });
    }
    res.status(201).json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.editDoc = async function (req, res) {
  try {
    const { title, text, status } = req.body;
    const document = await Document.findByIdAndUpdate(
      req.params.id,
      { title, text, status },
      { new: true }
    );

    if (!document) {
      return res.status(404).json({ message: "Document not found" });
    }
    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.deleteDoc = async function (req, res) {
  try {
    const document = await Document.findById(req.params.id);
    if (!document) {
      return res.status(404).json({ message: "Document not found" });
    }
    // document.markedForDeletion = true; // Don't have markedForDeletion field
    await document.save();
    return res.status(204).end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
