const { Document } = require("../../models/document");
const { Domain } = require("../../models/domain");

/*------------------------------------------------------------------------
  GET 
  /admin/documents
------------------------------------------------------------------------*/
exports.getDocuments = async function (req, res) {
  try {
    const page = req.query.page || 1;
    const pageSize = 10; // req.query.pageSize ?
    const docs = await Document.find()
      .select("-dtStatus -dtCr")
      .populate({
        path: "domainId",
        select: "name",
      })
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    if (!docs) return res.status(404).json({ message: "Documents not found" });
    return res.json(docs);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  GET
  /admin/documents/count
------------------------------------------------------------------------*/
exports.getDocumentsCount = async function (req, res) {
  try {
    const docsCount = await Document.countDocuments();

    if (!docsCount)
      return res.status(500).json({ message: "Could not count documents" });

    return res.json(docsCount);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/*------------------------------------------------------------------------
  POST 
  /admin/documents
------------------------------------------------------------------------*/
exports.addDocument = async function (req, res) {
  try {
    const { domainId, title, text, status } = req.body;

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

/*------------------------------------------------------------------------
  PUT 
  /admin/documents/:id
------------------------------------------------------------------------*/
exports.editDocument = async function (req, res) {
  try {
    const { domainId, title, text, status } = req.body;
    const updateFields = { dtUp: Date.now() };

    let document = await Document.findById(req.params.id);
    if (!document) {
      return res.status(404).json({ message: "Document not found" });
    }

    // Confirm If Domain Exists
    if (domainId != null) {
      const domain = await Domain.findById(domainId);
      if (!domain) return res.status(404).json({ message: "Domain not found" });
      updateFields.domainId = domain._id;
    }

    // Confirm If Required Fields != NULL
    if (title != null) updateFields.title = title.trim();
    if (text != null) updateFields.text = text.trim();
    // Confirm If new_Status != old_Status
    if (status != null && document.status != status) {
      updateFields.status = status.trim();
      updateFields.dtStatus = Date.now();
    }

    await document.set(updateFields).save();

    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
