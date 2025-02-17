const mh = require("../../helpers/media_helper");
const util = require("util");
const { Document } = require("../../models/document");
const { Domain } = require("../../models/domain");

exports.getDocs = async function (req, res) {
  try {
    const page = req.query.page || 1;
    const pageSize = 10; // req.query.pageSize ?
    const docs = await Document.find()
      .select("-tasks -dtStatus -dtCr")
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    if (!docs) return res.status(404).json({ message: "Documents not found" });
    return res.json(docs);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getDoc = async function (req, res) {
  try {
    const document = await Document.findById(req.params.id)
      .select("-dtStatus -dtCri")
      .populate("domainId", "name");
    if (!document)
      return res.status(404).json({ message: "Document not found" });
    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.addDoc = async function (req, res) {
  try {
    const { domainId, title, text, status } = req.body;

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

    const domain = await Domain.findById(domainId);
    if (!domain) return res.status(404).json({ message: "Domain not found" });

    let document = new Document({
      domainId: domain._id,
      title: title.trim(),
      text: text.trim(),
      status: status.trim(),
    });
    document = await document.save();
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
