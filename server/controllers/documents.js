const { Document } = require("../models/document");

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

exports.getDocById = async function (req, res) {
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
