const { Document } = require("../models/document");

/*------------------------------------------------------------------------
  GET 
  /documents/:id
------------------------------------------------------------------------*/
exports.getDocumentById = async function (req, res) {
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
