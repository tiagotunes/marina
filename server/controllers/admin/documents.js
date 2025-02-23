const { Document } = require("../../models/document");
const { Domain } = require("../../models/domain");

/*------------------------------------------------------------------------
  GET 
  /admin/documents
------------------------------------------------------------------------*/
exports.getDocuments = async function (req, res) {
  try {
    let docs;
    const page = req.query.page || 1;
    const pageSize = 10; // req.query.pageSize ?

    if (req.query.criteria) {
      let query = {};
      if (req.query.domain) {
        query["domain"] = req.query.domain;
      }
      switch (req.query.criteria) {
        case "new": {
          const daysAgo = new Date();
          daysAgo.setDate(daysAgo.getDate() - 7);
          query["dtCr"] = { $gte: daysAgo };
          break;
        }
        default:
          break;
      }
      docs = await Document.find(query)
        .select("-dtCr -dtUp")
        .populate({
          path: "domainId",
          select: "name",
        })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else if (req.query.domain) {
      docs = await Document.find({ domain: req.query.domain })
        .select("-dtCr -dtUp")
        .populate({
          path: "domainId",
          select: "name",
        })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else {
      docs = await Document.find()
        .select("-dtCr -dtUp")
        .populate({
          path: "domainId",
          select: "name",
        })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    }

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
  GET
  /admin/documents/search
------------------------------------------------------------------------*/
exports.searchDocuments = async function (req, res) {
  try {
    const searchTerm = req.query.q;
    // if (!searchTerm) {} make sense?

    const page = req.query.page || 1;
    const pageSize = 10;

    let query = {};
    if (req.query.domain) {
      query = { domain: req.query.domain };
    }

    if (searchTerm) {
      query = {
        ...query,
        $text: {
          $search: searchTerm,
          $language: "portuguese",
          $caseSensitive: false,
        },
      };
    }

    const searchResults = await Document.find(query)
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    return res.json(searchResults);
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

    const document = new Document({
      domainId: domain._id,
      title: title.trim(),
      text: text.trim(),
      status: status.trim(),
    }).save();

    if (!document) {
      return res.status(500).json({ message: "Document could not be created" });
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

    const document = await Document.findByIdAndUpdate(userId, updateFields, {
      new: true,
    });
    if (!document) return res.status(404).json({ message: "User not found" });

    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
